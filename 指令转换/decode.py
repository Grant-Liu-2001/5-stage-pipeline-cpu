import random

R_Type = {'add', 'sub', 'and', 'or', 'xor', 'sll', 'srl','sra','jr'}
I_Type = {'addi', 'andi', 'ori', 'xori', 'lw', 'sw', 'beq', 'bne', 'lui'}
J_Type = {'j', 'jal'}
value_dic = {}
save = 'code.txt'
full = 0

#创建与擦除保存文本
with open(save,'w') as f:
    f.write('')
    f.close()

for inst_mem in range (10) :
    func_all = input('要存入x数据，使用函数"load x 变量值"\n请输入cpu指令，直接回车结束输入：')
    if func_all == '':
        break

    elif full == 1:
        print('所存数据已满')
        break

    else:
        func_type = func_all.split()[0]

        #load x1 imm == addi x1 0 imm
        if func_type == 'load':
            x_value = func_all.split()[1]
            x_imm = func_all.split()[2]
            x_address = bin(random.randint(0,32)).replace('0b','').zfill(5)
            i = 0
            while ((x_address in value_dic.values()) or (x_address == 0)):
                x_address = bin(random.randint(0,32)).replace('0b','').zfill(5)
                i = i + 1
                if i >50: 
                    x_address = 0
                    full = 1
                    break
            if x_value not in value_dic :
                value_dic[x_value] = x_address
            op = '001000'
            rs = '00000'
            rt = value_dic[x_value]
            immediate = bin(int(x_imm)).replace('0b','').zfill(16)
            instruction = op + '_' + rs + '_' + rt + '_' + immediate

            #写入数据
            with open(save,'a') as f:
                f.write(instruction+'\n')
                f.close()

        #R_Type
        if func_type in R_Type:
            op = '000000'
            if func_type in {'add', 'sub', 'and', 'or', 'xor'}:
                sa = '00000'
                rd = func_all.split()[1]
                rs = func_all.split()[2]
                rt = func_all.split()[3]
                #add
                if func_type == 'add': func = '100000'
                #sub
                if func_type == 'sub': func = '100010'
                #and
                if func_type == 'and': func = '100100'
                #or
                if func_type == 'or': func = '100101'
                #xor
                if func_type == 'xor': func = '100110'
                instruction = op + '_' + value_dic[rs] + '_' + value_dic[rt] + '_' + value_dic[rd] + '_' + sa + '_' + func
                
                #写入数据
                with open(save,'a') as f:
                    f.write(instruction+'\n')
                    f.close()

            if func_type in {'sll', 'srl', 'sra'}:
                rs = '00000'
                rd = func_all.split()[1]
                rt = func_all.split()[2]
                sa = bin(int(func_all.split()[3])).replace('0b','').zfill(5)
                #sll
                if func_type == 'sll': func = '000000'
                #srl
                if func_type == 'srl': func = '000010'
                #sra
                if func_type == 'sra': func = '000011'
                instruction = op + '_' + rs + '_' + value_dic[rt] + '_' + value_dic[rd] + '_' + sa + '_' + func

                #写入数据
                with open(save,'a') as f:
                    f.write(instruction+'\n')
                    f.close()

            if func_type == 'jr':
                rs = func_all.split()[1]
                rt = '00000'
                rd = '00000'
                sa = '00000'
                func = '001000'
                instruction = op + '_' + value_dic[rs] + '_' + rt + '_' + rd + '_' + sa + '_' + func

                #写入数据
                with open(save,'a') as f:
                    f.write(instruction+'\n')
                    f.close()

        #I_Type
        elif func_type in I_Type:
            if func_type == 'lui':
                op = '001111'
                rs = '00000'
                rt = func_all.split()[1]
                x_imm = func_all.split()[2]
                immediate = bin(int(x_imm)).replace('0b','').zfill(16)
                instruction = op + '_' + rs + '_' + value_dic[rt] + '_' + immediate

                #写入数据
                with open(save,'a') as f:
                    f.write(instruction+'\n')
                    f.close()

            else:#lw x1 x2 offset == lw x1 offset(x2)，sw同理
                rt = func_all.split()[1]
                rs = func_all.split()[2]
                x_imm = func_all.split()[3]
                immediate = bin(int(x_imm)).replace('0b','').zfill(16)
                #addi
                if func_type == 'addi': op = '001000'
                #andi
                if func_type == 'andi': op = '001100'
                #ori
                if func_type == 'ori': op = '001101'
                #xori
                if func_type == 'xori': op = '001110'
                #lw
                if func_type == 'lw': op = '100011'
                #sw
                if func_type == 'sw': op = '101011'
                #beq
                if func_type == 'beq': op = '000100'
                #bne
                if func_type == 'bne': op = '000101'
                instruction = op + '_' + value_dic[rs] + '_' + value_dic[rt] + '_' + immediate

                #写入数据
                with open(save,'a') as f:
                    f.write(instruction+'\n')
                    f.close()

        #J_Type
        elif func_type in J_Type:   
            address = bin(int(func_all.split()[1])).replace('0b','').zfill(26)
            #j
            if func_type == 'j': op = '000010'
            #jal
            if func_type == 'jal': op = '000011'
            instruction = op + '_' + address

            #写入数据
            with open(save,'a') as f:
                f.write(instruction+'\n')
                f.close()

        print(instruction)