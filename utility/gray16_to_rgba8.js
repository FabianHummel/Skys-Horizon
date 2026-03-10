import fs from "node:fs";
import path from "node:path";
import { decode, encode } from "fast-png";

const inputPath = "assets/logo-animated.png";
const outputPath = "src/assets/skys_horizon/textures/misc/logo.png";

// correct working dir
if (path.basename(path.resolve()) === "utility") {
    process.chdir("../");
}

// read PNG
const buffer = fs.readFileSync(inputPath);
const png = decode(buffer);

const outData = new Uint8Array(png.width * png.height * 4);

for (let i = 0; i < png.width * png.height; i++) {
    const gray = png.data[i * 2];
    const alpha = png.data[i * 2 + 1];

    const idx = i * 4;
    outData[idx] = (gray >> 8) & 0xFF;  // map lower 8 bits to red
    outData[idx + 1] = gray & 0xFF;     // map upper 8 bits to green
    outData[idx + 2] = 0;               // blue is not used
    outData[idx + 3] = alpha;           // preserve alpha
}

const outPng = encode({
    width: png.width,
    height: png.height,
    channels: 4,
    data: outData,
});

fs.writeFileSync(outputPath, outPng);
