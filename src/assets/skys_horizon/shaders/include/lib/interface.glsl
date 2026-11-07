#ifndef SKYS_HORIZON_LIB_INTERFACE_GLSL
#define SKYS_HORIZON_LIB_INTERFACE_GLSL

// Declares one varying for both stages; the host defines VSH or FSH before including this
#if defined(VSH)
#define SH_FLAT_VARYING(loc, type, name) layout(location = loc) flat out type name;
#define SH_VARYING(loc, type, name) layout(location = loc) out type name;
#elif defined(FSH)
#define SH_FLAT_VARYING(loc, type, name) layout(location = loc) flat in type name;
#define SH_VARYING(loc, type, name) layout(location = loc) in type name;
#endif

#endif
