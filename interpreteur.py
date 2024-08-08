file = open("asm.txt", 'r')
asm = file.readlines()
asm = [ligne.strip().split(" ") for ligne in asm]
mem = [0] * 1024
ip = 0

while ip < len(asm):
    if asm[ip][1] == "AFC":
        reg = int(asm[ip][2])
        mem[reg] = int(asm[ip][3])
        ip = ip + 1
    
    elif asm[ip][1] == "COP":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        mem[reg1] = mem[reg2]
        ip = ip + 1

    elif asm[ip][1] == "INF":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] < mem[reg3] else 0
        ip = ip + 1
    
    elif asm[ip][1] == "SUP":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] > mem[reg3] else 0
        ip = ip + 1

    elif asm[ip][1] == "EQU":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] == mem[reg3] else 0
        ip = ip + 1
    
    elif asm[ip][1] == "INFE":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] <= mem[reg3] else 0
        ip = ip + 1

    elif asm[ip][1] == "SUPE":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] >= mem[reg3] else 0
        ip = ip + 1

    elif asm[ip][1] == "NEQU":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = 1 if mem[reg2] != mem[reg3] else 0
        ip = ip + 1

    elif asm[ip][1] == "ADD":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = mem[reg2] + mem[reg3]
        ip = ip + 1

    elif asm[ip][1] == "SUB":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = mem[reg2] - mem[reg3]
        ip = ip + 1

    elif asm[ip][1] == "MUL":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = mem[reg2] * mem[reg3]
        ip = ip + 1

    elif asm[ip][1] == "DIV":
        reg1 = int(asm[ip][2])
        reg2 = int(asm[ip][3])
        reg3 = int(asm[ip][4])
        mem[reg1] = mem[reg2] / mem[reg3]
        ip = ip + 1

    elif asm[ip][1] == "LOAD":
        reg = int(asm[ip][2])
        addr = int(asm[ip][3])
        mem[reg] = mem[addr]
        ip = ip + 1
    
    elif asm[ip][1] == "STR":
        addr = int(asm[ip][2])
        reg = int(asm[ip][3])
        mem[addr] = mem[reg]
        ip = ip + 1
    
    elif asm[ip][1] == "JMP":
        ip = int(asm[ip][2])

    elif asm[ip][1] == "CALL":
        ip = int(asm[ip][2])

    elif asm[ip][1] == "PRI":
        addr = int(asm[ip][2])
        print(mem[addr])
        ip = ip + 1
    
    elif asm[ip][1] == "JMPF":
        reg = int(asm[ip][2])
        addr = int(asm[ip][3])
        if mem[reg] == 0:
            ip = addr
        else:
            ip = ip + 1

    else:
        ip = ip + 1

print(mem)
