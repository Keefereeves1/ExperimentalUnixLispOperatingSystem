// kernel.h
#ifndef KERNEL_H
#define KERNEL_H

#include <stdio.h>

// Function to initialize the kernel
void kernel_init();

// Function to run the kernel
void kernel_run();

// Function to halt the kernel and clean up resources
void kernel_halt();

// Function to send a message from Lisp to the kernel
void send_message(const char* message);

#endif

