Programação Orientada a Objetos, é um paradigma de programação baseada no conceito que objetos contém dados (atributos ou *fields*) e comportamentos (methods ou *methods*). 

Com o objetivo de no design de software para a melhor representação do mundo real. Usado para: Melhorar a reutilização do código; manutenibilidade e escalabilidade; mais fácil de entender e fácil manutenção; proximo as entidade do mundo real.
## Conceitos chaves

### Classes

É como um "molde" ou "planta arquitetônica" (blueprint). Ela define quais dados (variáveis) e comportamentos (métodos) um certo tipo de dado terá. Em vez de escrever o mesmo código múltiplas vezes, você cria uma classe para centralizar esse formato.
Em geral, as declarações de classe podem incluir os seguintes componentes, nesta ordem: 
- **Modificadores** : Uma classe pode ser pública ou ter acesso padrão .
- **Nome da classe:** Por convenção, o nome da classe deve começar com a letra inicial maiúscula.
- **Corpo:** O corpo da classe é delimitado por chaves, { }.

#### Exemplo 

Um carro representa uma classe (modelo), enquanto BMW, Mercedes e Audi representam objetos (instâncias) criados a partir dessa classe.![[Class.webp]]
Em *Dart*

``` dart

class Carro {
  String marca;
  String modelo;

  // Construtor
  Carro(this.marca, this.modelo);
}

```
### Objects

É a "instância" concreta criada a partir desse molde.

``` dart
void main(){
	
// OBJETO: A instância concreta criada a partir da classe
  Carro meuCarro = Carro('BMW', 'X5');
  Carro outroCarro = Carro('Audi', 'A4');
  
  print(meuCarro.marca); // Imprime: BMW
}
```

Outro Exemplo

![[Object.webp]]
### Encapsulamento (*Encapsulation*)

No JavaScript antigo, quase tudo num objeto era público e acessível de fora. O encapsulamento é a prática de unir os dados e os métodos que os manipulam em uma única unidade (a classe) e **esconder os dados internos** (informações de estado) do acesso externo. Em vez de modificar uma variável diretamente, a linguagem fornece restrições de acesso (como propriedades `private`) e você altera esses valores usando métodos públicos controlados (como _getters_ e _setters_)![[Encapsulation.webp]]
``` dart
class Carro {
  String marca;
  
  // Propriedade privada (Encapsulada)
  // O usuário não pode simplesmente fazer "carro._velocidade = 5000"
  double _velocidade = 0; 

  Carro(this.marca);

  // Getter público para ler o valor de forma segura
  double get velocidade => _velocidade;

  // Método público para modificar o dado de forma controlada
  void acelerar(double incremento) {
    if (incremento > 0) {
      _velocidade += incremento;
      print('$marca acelerou para $_velocidade km/h');
    }
  }
}
```
### Abstração (*Abstraction*)

É o princípio de **ocultar a complexidade de implementação** e mostrar apenas as funcionalidades essenciais para quem está usando o objeto. É o equivalente a usar um método nativo no JavaScript como o `console.log()`: você sabe o que ele faz e sabe como usá-lo, mas não precisa se preocupar com os detalhes complexos de como o motor V8 o executa internamente. Um exemplo do mundo real seria uma máquina de café ou um caixa eletrônico

![[Abstraction.webp|646]]

``` dart
// Classe abstrata: Define O QUE o carro faz, mas não COMO ele faz.
abstract class Veiculo {
  void ligarMotor(); // Método abstrato (sem corpo)
}

class Carro extends Veiculo {
  String marca;
  Carro(this.marca);

  @override
  void ligarMotor() {
    // A complexidade fica escondida aqui dentro.
    // Quem usa o método não precisa saber sobre bomba de combustível, velas e cilindros.
    print('Injetando combustível... Gerando faísca... Motor do $marca ligado!');
  }
}
```
### Herança (*Inheritance*)

Permite que uma classe filha (subclasse) herde propriedades e métodos de uma classe pai (superclasse). Isso estabelece uma relação do tipo "é um". Isso evita duplicação de código (reutilização). Exemplo clássico: as classes `Cachorro`, `Gato` e `Vaca` podem herdar características comuns de uma classe base chamada `Animal`

``` dart
// Classe Pai (Superclasse)
class Carro {
  String marca;
  Carro(this.marca);

  void buzinar() {
    print('Bi-bi!');
  }
}

// Classe Filha (Subclasse): Um CarroEsportivo "é um" Carro 
class CarroEsportivo extends Carro {
  bool temTurbo;

  // Reutiliza o construtor da classe pai usando "super"
  CarroEsportivo(String marca, this.temTurbo) : super(marca);

  void ativarTurbo() {
    print('Turbo ativado no $marca! Ganhando mais velocidade.');
  }
}

void main() {
  CarroEsportivo porsche = CarroEsportivo('Porsche', true);
  porsche.buzinar();     // Método herdado da classe pai
  porsche.ativarTurbo(); // Método específico da classe filha
}
```
### Polimorfismo  (*Polymorphism*)

Significa "muitas formas". É a capacidade de **tratar diferentes objetos de maneira uniforme** ou de fazer com que **um mesmo método se comporte de maneira diferente dependendo de quem o chama**

``` dart
class Carro {
  void acelerar() {
    print('O carro está acelerando: Vrummm!');
  }
}

// Polimorfismo na prática:
class CarroEletrico extends Carro {
  // Sobrescrevemos o método da classe pai para mudar o seu comportamento
  @override
  void acelerar() {
    print('O carro elétrico está acelerando: (Silêncio total)... zzzzz');
  }
}

class CarroEsportivo extends Carro {
  @override
  void acelerar() {
    print('O carro esportivo está acelerando: VRUUUMMM RATATATA!');
  }
}

void main() {
  // O mesmo método acelerar() gera resultados diferentes dependendo do tipo de carro 
  Carro meuTesla = CarroEletrico();
  Carro meuFerrari = CarroEsportivo();

  meuTesla.acelerar();   // Imprime o som silencioso
  meuFerrari.acelerar(); // Imprime o som do motor esportivo
}
```