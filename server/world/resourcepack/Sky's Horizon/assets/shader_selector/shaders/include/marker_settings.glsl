
// define distinct values, counting from 1:
#define SCREENSHAKE_CHANNEL 1

/*
signature:
 ADD_MARKER(channel, id, op)
*/
// append different marker definitions
#define LIST_MARKERS ADD_MARKER(SCREENSHAKE_CHANNEL, 1, 1)

#define MARKER_ALPHA 251

// Screen pixel that the marker ends up on if it uses channel k:
// Mapping follows structure that is like an inverted cantor pairing (but only producing coordinates with an even sum)
#define MARKER_POS(k) (ivec2(2*int(ceil(sqrt(float(k))) - 1.0),0) + (k - int((ceil(sqrt(float(k))) - 1.0)*(ceil(sqrt(float(k))) - 1.0)) - 1)*ivec2(-1, 1))
