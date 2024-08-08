import sys
def extract_assembler_code(input_data):
    lignes = input_data.strip().splitlines()
    assembler_code = []
    
    for ligne in lignes:
        if any(instr in ligne for instr in ["JMP", "AFC", "ADD", "COP", "EQU", "JMPF", "RET"]):
            instruction = ligne.split(":")[1].strip()
            for _ in range(4-len(instruction.split())):
                instruction=instruction+" 0"
            assembler_code.append(instruction)
    
    return "\n".join(assembler_code)

input_data = sys.stdin.read()
assembler_code = extract_assembler_code(input_data)
print(assembler_code)