#include <stdint.h>
#include <unistd.h> 

volatile unsigned int* gpio_data = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe = (volatile unsigned int *) 0x40000004;



int main() {
    // Configure the GPIO as an output
    *gpio_oe = 0xFFFFFFFF;  // Set all pins to output

    while (1) { 
        //this will cycle through all 32 bits of gpio data 1 by 1, ie it assumes each bit is a port
        for (int i = 0; i < 32; i++) {
            *gpio_data = (1 << i);
        }
        *gpio_data = 0x00000000; 
    }

    return 0;
}