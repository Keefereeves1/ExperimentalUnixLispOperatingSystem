# Compiler and compiler flags
CC := clang
CFLAGS := -Wall -Wextra -std=c11 -Iinclude

# Source files
SRC_DIR := src
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)

# Object files
OBJ_DIR := obj
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

# Library file
LIB_DIR := lib
LIBRARY := $(LIB_DIR)/libc.a

# Targets
.PHONY: all clean

all: $(LIBRARY)

$(LIBRARY): $(OBJ_FILES)
    $(AR) rcs $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
    $(CC) $(CFLAGS) -c -o $@ $<

clean:
    rm -rf $(OBJ_DIR)/*.o $(LIBRARY)

# Dependency rules
$(OBJ_FILES): | $(OBJ_DIR)

$(OBJ_DIR):
    mkdir -p $@

