#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

// Define the maximum memory size
#define MAX_MEMORY_SIZE (1024 * 1024) // 1 MB

// Define the memory block structure
typedef struct {
    uint8_t *ptr;       // Pointer to the memory block
    size_t size;        // Size of the memory block
    bool allocated;     // Indicates if the block is allocated
} MemoryBlock;

// Define the memory pool
static uint8_t memory[MAX_MEMORY_SIZE];

// Define an array of memory blocks
#define MAX_BLOCKS 100
static MemoryBlock memoryBlocks[MAX_BLOCKS];

// Initialize the memory manager
void memory_init() {
    for (int i = 0; i < MAX_BLOCKS; i++) {
        memoryBlocks[i].ptr = NULL;
        memoryBlocks[i].size = 0;
        memoryBlocks[i].allocated = false;
    }
}

// Function to allocate memory
void *memory_allocate(size_t size) {
    for (int i = 0; i < MAX_BLOCKS; i++) {
        if (!memoryBlocks[i].allocated && size <= memoryBlocks[i].size) {
            memoryBlocks[i].allocated = true;
            return memoryBlocks[i].ptr;
        }
    }
    return NULL; // Memory allocation failed
}

// Function to deallocate memory
void memory_deallocate(void *ptr) {
    for (int i = 0; i < MAX_BLOCKS; i++) {
        if (memoryBlocks[i].ptr == ptr && memoryBlocks[i].allocated) {
            memoryBlocks[i].allocated = false;
            return;
        }
    }
}

int main() {
    // Initialize the memory manager
    memory_init();

    // Allocate and deallocate memory blocks
    void *ptr1 = memory_allocate(128);
    void *ptr2 = memory_allocate(64);

    if (ptr1 && ptr2) {
        printf("Memory allocated successfully.\n");

        // Deallocate memory blocks
        memory_deallocate(ptr1);
        memory_deallocate(ptr2);

        printf("Memory deallocated.\n");
    } else {
        printf("Memory allocation failed.\n");
    }

    return 0;
}

