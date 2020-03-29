.global _start

_start:

    movq $20, %r8       #store value of x in %r8
    movq %r8, %rax      # move value into rax
    movq $0, %rdi       #store initial value of i in %rdi
    movq $0, %r11       #store answer in r11
    movq $1, %rcx       #store initial value of fact in %rcx
    jmp .loop           #jump to loop label

.loop:                  #loop

    addq $1, %rdi       #add 1 to the value of i( we start with natural numbers not whole numbers)
    addq $1, %r11       #add 1 to the final answer
    imulq %rdi, %rcx    #multiply fact=fact * i and store back in %rcx
    movq %rax, %rbx     #move value of x from rax to rbx as division would need rax to contain fact
    movq %rcx, %rax     #copy value of fact from rcx to rax for the division operation
    movq $0, %rdx       #added all zeroes to rdx( needed by the division operation for unsigned)
    divq %rbx           #perform (%rdx:%rax) / %rdi
    movq %rbx, %rax     #move back the value of x from rbx to rax
    test %rdx, %rdx     #set ZF to 1 if rdx == 0
    jne .loop           #if remainder not equal to zero loop again

exit:                   #if remainder ==0 , value in r11 shows the least postive integer whose factorial is divisible by x
             
    mov $60, %rax
    xor %rdi, %rdi
    syscall
