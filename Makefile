CXX      = g++
STRIP    = strip
OUT_NAME = chatlog.asi
SRC_DIR  = src

# --- Compiler Flags ---
# -m32: Required for GTA San Andreas (32-bit)
# -Os: Optimize for small file size
# -Wall: Show all warnings (helps find bugs)
# -static: Link everything statically so users don't need extra DLLs
CXXFLAGS = -m32 -Os -Wall -static-libgcc -static-libstdc++

# --- Linker Flags ---
# -shared: Create a DLL/ASI
# -Wl,--subsystem,windows:5.1: Magic flag for Windows XP compatibility
# -lshlwapi -lole32: Libraries needed for finding "My Documents"
LDFLAGS  = -shared -Wl,--subsystem,windows:5.1 -lshlwapi -lole32

# --- Logic ---
SOURCES = $(SRC_DIR)/dllmain.cpp

all: $(OUT_NAME)

$(OUT_NAME): $(SOURCES)
	@echo [BUILDING] Generating $(OUT_NAME)...
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)
	@echo [STRIPPING] Removing debug symbols...
	$(STRIP) $@
	@echo [SUCCESS] Build Complete!

clean:
	@if exist $(OUT_NAME) del $(OUT_NAME)
	@echo [CLEAN] Removed $(OUT_NAME)