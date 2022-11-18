Versionamento de definição: <breaking_change>.<legacy_fix>
# Infleet Mars
# Definição 1.2

## API Rest:

### Enums:
* **directionEnum**: oneOf(['N', 'L', 'O', 'S'])
* **movementEnum**: oneOf(['E','D','M'])
* **movementString**: stringOf(movementEnum)

### Definições para movimentação:
* **errorIndexes**: listOf(errorIndexes(movementString)): "se algum movimento ou vários apresentaram algum status de erro parcial ou completo, retorna a lista de índices dos movimentos com erros. Lista vazia [] se executou tudo sem erros."
* **completed**: bool, "completou com sucesso ou não"
* **lastIndex**: int: "se completed = false, sem sucesso, demonstra qual foi o índice do último comando executado com sucesso.

### Rotas HTTP:
* **get /**, "retorna lista os carros e posições atuais no formato carStatus = [{id: carId, position: [x, y], direction: directionEnum}]"
* **post /move/:id**, *body*: {move: movementString}, "retorna o comando e seu resultado no formato {id: carId, move: movementString, status: {startPosition: [x, y], startDirection: directionEnum, finalPosition: [x, y], finalDirection: directionEnum, completed: bool, lastIndex: int, errorIndexes: errorIndexes}}"