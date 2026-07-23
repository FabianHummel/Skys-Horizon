from concurrent.futures import Future, ThreadPoolExecutor, as_completed
from typing import Callable, ParamSpec, TypeVar

from beet import File

_T = TypeVar("_T")
_P = ParamSpec("_P")


def beet_run_threaded(
    config: dict,
    assets: dict[str, File],
    fn: Callable[_P, _T],
    /,
    *args: _P.args,
    **kwargs: _P.kwargs,
) -> dict[str, _T]:
    max_workers = config.get("workers") or 8

    futures: dict[Future, str] = {}

    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        for path, asset in assets.items():
            future = executor.submit(fn, path, asset, *args, **kwargs)
            futures[future] = path

        results: dict[str, _T] = {}

        for future in as_completed(futures):
            path = futures[future]
            results[path] = future.result()

        return results
