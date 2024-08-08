file=open("asm.txt",'r')
lignes=file.readlines()
lignes=[ligne.strip().split(" ") for ligne in lignes]
resultat=[]
def str_to_hex(A):
    result=str(hex(int(A)))[2:]
    if(len(result)<2):
        result="0"+result
    return result   
def transforme_liste_en_chaine(liste):
    chaine = ','.join(['X"' + valeur[2:] + '"' for valeur in liste])
    return '(' + chaine + ',others=>X"00000000"'+ ')'
for instruct in lignes:
    opp=instruct[0]
    A=str_to_hex(instruct[1])
    B=str_to_hex(instruct[2])
    C=str_to_hex(instruct[3])
    if(opp=="AFC"):
        resultat.append("0x06"+A+B+"00")
        print("AFC R"+A+" "+B) 
    elif(opp=="COP"):
        if(int(instruct[1])<int(instruct[2])):
            #dans ce cas on a un store 
            resultat.append("0x08"+A+B+"00")
            print("STR @"+A+" R"+B) 
        else:
            #dans ce cas on un load
            resultat.append("0x07"+A+B+"00")
            print("LOAD R"+A+" @"+B)
    elif(opp=="ADD"):
        resultat.append("0x01"+A+B+C)
        print("ADD R"+A+" R"+B+" R"+C)
    elif(opp=="SUB"):
        resultat.append("0x03"+A+B+C)
        print("SUB R"+A+" R"+B+" R"+C)
    elif(opp=="MUL"):
        resultat.append("0x02"+A+B+C)
        print("MUL R"+A+" R"+B+" R"+C)
    elif(opp=="INF"):
        resultat.append("0x09"+A+B+C)
        print("INF R"+A+" R"+B+" R"+C)
    elif(opp=="INFE"):
        resultat.append("0x19"+A+B+C)
        print("INFE R"+A+" R"+B+" R"+C)
    elif(opp=="SUP"):
        resultat.append("0x0A"+A+B+C)
        print("SUP R"+A+" R"+B+" R"+C)
    elif(opp=="SUPE"):
        resultat.append("0x1A"+A+B+C)
        print("SUPE R"+A+" R"+B+" R"+C)
    elif(opp=="EQU"):
        resultat.append("0x0B"+A+B+C)
        print("EQU R"+A+" R"+B+" R"+C)
    elif(opp=="NEQU"):
        resultat.append("0x2B"+A+B+C)
        print("NEQU R"+A+" R"+B+" R"+C)
    elif(opp=="PRI"):
        resultat.append("0x0C"+A+"00"+"00")
        print("PRINT @"+A)
    elif(opp=="JMP"):
        resultat.append("0x0D"+A+"00"+"00")
        print("JMP "+A)
    elif(opp=="JMPF"):
        resultat.append("0x0E"+A+B+"00")
        print("JMF R"+A+" "+B)
    else:
        resultat.append("0x000000")
        print("NOPE")
       
print(transforme_liste_en_chaine(resultat))


