# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c99
LDFLAGS = -L./libc -lc -lm

# Source files
KERNEL_SOURCES = kernel/kernel.c
LIBC_SOURCES = libc/*.c
LISP_SOURCES = lisp/*.lisp
MAIN_SOURCE = main.c

# Output executable
OUTPUT = os

# Build the C kernel
$(OUTPUT): $(KERNEL_SOURCES)
	$(CC) $(CFLAGS) $(KERNEL_SOURCES) -o $(OUTPUT) $(LDFLAGS)

# Build the C standard library (libc.a)
libc.a:
	cd libc && $(MAKE)

# Build the Lisp code (Assuming you have the Lisp interpreter)
lisp: $(LISP_SOURCES)
	your-lisp-interpreter $(LISP_SOURCES)

# Clean build artifacts
clean:
	rm -f $(OUTPUT)
	cd libc && $(MAKE) clean

