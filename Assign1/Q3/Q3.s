.global _start

_start:
    movq $1, %r8        #move a to r8
    movq $100, %r9        #move b to r9
    movq $5, %r10     #move n to r10

    movq %r8, %rbx      #make a copy of a in rbx
    movq %r9, %rcx      #make a copy of b in rcx
    movq $1, %r11       #acc=1 initital value

    movq %rbx, %rax     #performing a=a%n
    movq $0, %rdx       #sign extension for unsigned
    divq %r10           #unsigned division
    movq %rdx, %rbx     #move remainder back to rbx(updated a)

.condition:             #checks if while loop is valid
    cmp $0, %rcx        #check if b>0
    jg .odd             #execute if inside while loop
    jmp exit            #if b <=0, the program ends

.odd:                   #checks if b is odd and if yes performs suitable computations
    movq %rcx, %r12     #to check if b is odd
    and $1, %r12        #if odd then != 0 and vice versa
    cmp $0, %r12        #b&1
    je .loop            #if ==0, must be even therefore do not execute the statements exclusive for odd
    imulq %rbx, %r11    #acc=acc*a
    movq %r11, %rax     #computing acc % n
    movq $0, %rdx       #sign extension for unsigned
    divq %r10           #unsigned division
    movq %rdx, %r11     #move remainder back to r11(updated acc)
    jmp .loop           #move to loop

.loop:
    shrq $1, %rcx       #b=b/2, we did an logical right shift
    imulq %rbx, %rbx    #a=a*a
    movq %rbx, %rax     #computing a % n
    movq $0, %rdx       #sign extension for unsigned
    divq %r10           #unsigned division
    movq %rdx, %rbx     #move remainder back to rbx(updated a)
    jmp .condition      #check condition again before looping back
   
exit:
    mov $60, %rax
    xor %rdi, %rdi
    syscall





