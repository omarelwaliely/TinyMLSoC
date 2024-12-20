#include <stdint.h>
#include <stddef.h>
volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;

volatile unsigned int* i2s_en = (volatile unsigned int*) 0x44000000;
volatile unsigned int* i2s_done = (volatile unsigned int*) 0x44000004;
volatile unsigned int* i2s_data = (volatile unsigned int*) 0x44000008;
volatile unsigned int* i2s_fifo_status = (volatile unsigned int*) 0x4400000C;
volatile unsigned int* i2s_fifo_data = (volatile unsigned int*) 0x44000010;



volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

volatile unsigned int* uart_ctrl = (volatile unsigned int *) 0x80000000;
volatile unsigned int* uart_bauddiv = (volatile unsigned int *) 0x80000004;
volatile unsigned int* uart_status = (volatile unsigned int *) 0x80000008;
volatile unsigned int* uart_data = (volatile unsigned int *) 0x8000000C;


volatile unsigned int* dmac_saddr   = (volatile unsigned int*) 0x60000000;
volatile unsigned int* dmac_daddr   = (volatile unsigned int*) 0x60000004;
volatile unsigned int* dmac_ctrl    = (volatile unsigned int*) 0x60000008;
volatile unsigned int* dmac_scfg    = (volatile unsigned int*) 0x6000000C;
volatile unsigned int* dmac_dcfg    = (volatile unsigned int*) 0x60000010;
volatile unsigned int* dmac_cfg     = (volatile unsigned int*) 0x60000014;
volatile unsigned int* dmac_bcount  = (volatile unsigned int*) 0x60000018;
volatile unsigned int* dmac_bsize   = (volatile unsigned int*) 0x6000001C;
volatile unsigned int* dmac_status  = (volatile unsigned int*) 0x60000020;


typedef struct {
    unsigned int saddr;    
    unsigned int daddr;    
    unsigned char bcount;
    unsigned char bsize;
    unsigned char sinc;
    unsigned char dinc;
    unsigned char ssize;
    unsigned char dsize;
    unsigned char wfi;
    unsigned char irqsrc;
} dmac_descriptor;


volatile int flag = 0;
void uart_putc(char c);
void uart_puts_hex(int num);

void enable_IRQ(void (*isr)(void)) {
    asm volatile("csrw mtvec, %0" :: "r"(isr));
    asm volatile("csrsi mstatus, 0x8");
    asm volatile("csrsi mie, 0x8");
}
void return_m(void){
    asm volatile("mret");
}

void isr_handler(void) {
    flag = 1;    
    return_m();

}

void delay(unsigned int milliseconds) {
    *LOAD_VALUE = milliseconds * 6000; // 6000 for 6MHz clock
    *TIMER_STATUS = 0x0000001;
    while ((*TIMER_STATUS & 0x100) == 0) {

    }
}

void uart_init(int bauddiv) {
    *uart_bauddiv = bauddiv;
    *uart_ctrl = 1;
}

void uart_putc(char c) {
    while (*uart_status == 0);
    *uart_data = c;
    *uart_ctrl |= 2;
}

void uart_puts(char *s) {
    for (int i = 0; s[i]; i++)
        uart_putc(s[i]);
}

void uart_puts_hex(int num) {
    char hex_string[11]; // 8 characters for 32-bit hex + \r + \n + null terminator
    for (int i = 0; i < 8; i++) {
        int nibble = (num >> (28 - 4 * i)) & 0xF; // Extract each hex nibble
        if (nibble < 10) {
            hex_string[i] = '0' + nibble; // 0-9
        } else {
            hex_string[i] = 'A' + (nibble - 10); // A-F
        }
    }
    hex_string[8] = '\r'; // Carriage return
    hex_string[9] = '\n'; // Newline
    hex_string[10] = '\0'; // Null terminator

    uart_puts(hex_string); // Send the hex string with UART
}

void dmac_init(dmac_descriptor *d){
    *dmac_saddr = d->saddr;
    *dmac_daddr = d->daddr;
    *dmac_scfg  = d->ssize  + d->sinc*16;
    *dmac_dcfg  = d->dsize  + d->dinc*16;
    *dmac_cfg   = d->wfi    + d->irqsrc*16;
    *dmac_bcount= d->bcount;
    *dmac_bsize = d->bsize;
}

void *memset(void *s, int c, size_t n) {
    unsigned char *ptr = s;
    while (n--) {
        *ptr++ = (unsigned char)c;
    }
    return s;
}
   // dmac_descriptor dd;

int main() {
    dmac_descriptor dd;
    uint32_t mic_out[16] = {0};
    dd.saddr = 0x44100000;
    dd.daddr =  (unsigned int) mic_out;
    dd.bcount = 16;
    dd.bsize = 8;
    dd.wfi = 0;
    dd.irqsrc = 0;
    dd.sinc=1;
    dd.dinc=1;
    dd.ssize=0;
    dd.dsize=0;

    dmac_init(&dd);
    //dmac_start();

    enable_IRQ(isr_handler);


    volatile int add = 0x00000009;
   *i2s_en = add;
    uart_init(3);         // Initialize UART with a baud rate setting

    volatile unsigned int x;
    volatile char c1, c2;
                  *gpio_data_A = 3;

    volatile int count =0;
    while (1) {
        //count +=1;
        if(flag){
            // while(*i2s_fifo_status != 0x00000001){
            //     x = *i2s_fifo_data;
            //     uart_puts_hex(x);
            // }
            flag = 0;
        }
    }
    return 0;
}