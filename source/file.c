#define VRAM ((volatile short*)0x06000000)

void doit() {
	VRAM[60 * 240 + 60] = 0x001f;
}
