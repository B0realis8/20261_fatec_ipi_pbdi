def soma():
    while True:
        valor1: int = input("Insira um valor:")
        try:
            valor1 = int(valor1)
            break
        except ValueError:
            print("Valor inválido.")
            
    valor2: int = int(input("Insira outro valor:"))
    soma = valor1+valor2
    print(soma)

soma()