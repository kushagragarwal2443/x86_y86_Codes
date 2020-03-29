
.global _start

_start:

    movq %rbx, %r8       #initialise r8 with value X=A 
    movq %rcx, %r9       #initialise r9 with value B

.loop:

    movq $0, %rdx       #preparing for division
    movq %rbx, %rax     #setting numerator=A
    divq %r8            #division of A/X    
    movq %r8, %r10      #store X in r10
    movq %r9, %r11      #initialise r11 with value of i=B
    cmpq $0, %rdx       #compare A%X
    je .gcd             #if remainder==0 go check if X is coprime with B
    jmp .loopb

.loopa:
          
    subq $1, %r11       #checking if gcd ==1
    cmpq $0, %r11       #if gcd-1 ==0
    je .sum             #if yes then go to the sum function or else loop over
    jmp .loopb

.loopb:

    subq $1, %r8        #if not, then reduce r8 by 1
    jmp .loop           #and loop over

.gcd:                   #if gcd of %r9 and %r10 == 1, then they are coprime

    movq $0, %rdx       #preparing for division
    movq %r10, %rax     #mov X to numerator
    divq %r11           #division of X by i
    movq %rdx, %r12     #move remainder in r12

    movq $0, %rdx       #preparing for division
    movq %r9, %rax      #mov b to numerator
    divq %r11           #division of b by i
    movq %rdx, %r13     #move remainder to r13

    cmpq $0, %r13       #for coprime both r13 and r12 ==0 and r11=1
    je .final           #if r13==0 go check for r12

    subq $1, %r11       #if not 0, loop back on gcd with i++
    jmp .gcd            #loop back

.final:

    cmpq $0, %r12       #if r13==0, r12 must also be equal to 0
    je .loopa           #if r12 also zero go back to main
    subq $1, %r11       #if not update r11 and loop back
    jmp .gcd            #reiterate over the gcd

.sum:

    movq %r10, %r11     #for safety storing value of r10 in r11
    movq $0, %r12       #sumofdigits =0 at start
    movq $10, %r13      #this is the number we need to divide with
    jmp .loopc

.loopc:

    movq $0, %rdx       #preparing for division
    movq %r11, %rax     #mov X to numerator
    divq %r13           #division of X by 10
    addq %rdx, %r12     #move remainder in r12
    movq %r12, %rdx     #store final answer in register rdx
    cmpq $0, %rax       #check if divisor=0
    je exit             #if yes, finish execution
    movq %rax, %r11     #move the divisor into r11 to acts as numerator
    jmp .loopc

exit:

    mov     $60, %rax           
    xor     %rdi, %rdi              
    syscall           # The code ends its execution here 




    