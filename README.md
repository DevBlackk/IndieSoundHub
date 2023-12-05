# Documentação do  IndieSoundHub

## Visão Geral

Bem-vindo ao Projeto de Distribuição de Música! Esta documentação fornece um guia abrangente para usuários técnicos e não técnicos. Se você é um artista independente, um ouvinte ou alguém interessado em entender o projeto, esta documentação está aqui para ajudar.

## Índice

- [Introdução ao Projeto](#introdução-ao-projeto)
- [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)
  - [Tabelas](#tabelas)
  - [Dados Fictícios](#dados-fictícios)
- [Exemplos de Consultas](#exemplos-de-consultas)
- [Guia de Uso](#guia-de-uso)
  - [Para Artistas](#para-artistas)
  - [Para Ouvintes](#para-ouvintes)
- [Próximos Passos](#próximos-passos)
- [Contribuições](#contribuições)

## Introdução ao Projeto

O  IndieSoundHub tem como objetivo capacitar artistas independentes, proporcionando uma plataforma para compartilhar e distribuir suas músicas. Também oferece aos ouvintes um local para descobrir e apreciar conteúdo musical diversificado. Esta documentação abrange a estrutura do banco de dados, dados de exemplo, consultas de exemplo e guias do usuário.

## Estrutura do Banco de Dados

### Tabelas

1. **`user`**: Armazena informações do usuário, incluindo artistas e ouvintes.
2. **`artist`**: Detalhes sobre artistas, vinculados à tabela `user`.
3. **`contract`**: Contratos entre artistas e detentores de direitos autorais.
4. **`copyright_holder`**: Informações sobre detentores de direitos autorais.
5. **`copyright_information`**: Associação entre músicas e detentores de direitos autorais.
6. **`music`**: Informações sobre músicas, vinculadas a álbuns.
7. **`album`**: Detalhes sobre álbuns, vinculados a artistas.
8. **`streaming_history`**: Histórico de reprodução do usuário.
9. **`streaming_service`**: Informações sobre serviços de streaming.
10. **`revenue_distribution`**: Distribuição de receitas associadas a músicas e serviços de streaming.

### Dados Fictícios

Dados de exemplo foram inseridos para ilustrar como o sistema funciona. Essas entradas fictícias incluem usuários, artistas, contratos, detentores de direitos autorais, músicas, álbuns, histórico de streaming, serviços de streaming e distribuição de receitas.

## Exemplos de Consultas

1. **[Consulta: Informações do Artista e Contrato](#consulta-informações-do-artista-e-contrato)**
2. **[Consulta: Músicas e Informações de Direitos Autorais](#consulta-músicas-e-informações-de-direitos-autorais)**
3. **[Consulta: Histórico de Reprodução e Músicas](#consulta-histórico-de-reprodução-e-músicas)**
4. **[Consulta: Receita por Serviço de Streaming](#consulta-receita-por-serviço-de-streaming)**

### Consulta: Informações do Artista e Contrato

```sql
SELECT * FROM artist
JOIN contract ON artist.id = contract.artist_id
WHERE artist.id = 1;
```

Esta consulta recupera informações sobre um artista específico e seu contrato.

### Consulta: Músicas e Informações de Direitos Autorais

```sql
SELECT music.title, copyright_holder.name, copyright_information.percentage
FROM music
JOIN copyright_information ON music.id = copyright_information.music_id
JOIN copyright_holder ON copyright_information.copyright_holder_id = copyright_holder.id
WHERE music.album_id = 2;
```

Esta consulta obtém detalhes sobre músicas, incluindo informações sobre detentores de direitos autorais, de um álbum específico.

### Consulta: Histórico de Reprodução e Músicas

```sql
SELECT streaming_history.timestamp, music.title, album.title AS album_title
FROM streaming_history
JOIN music ON streaming_history.music_id = music.id
JOIN album ON music.album_id = album.id
WHERE streaming_history.user_id = 3;
```

Esta consulta fornece um histórico de reprodução para um usuário específico, incluindo títulos de músicas e nomes de álbuns.

### Consulta: Receita por Serviço de Streaming

```sql
SELECT streaming_service.service_name, revenue_distribution.revenue_share_percentage
FROM streaming_service
JOIN revenue_distribution ON streaming_service.id = revenue_distribution.streaming_service_id
WHERE streaming_service.id = 1;
```

Esta consulta mostra percentagens de distribuição de receitas para um serviço de streaming específico.

## Guia de Uso

### Para Artistas

Como artista na plataforma, você pode:
- Carregar e gerenciar suas músicas e álbuns.
- Visualizar e gerenciar seus contratos e distribuição de receitas.
- Interagir com ouvintes através da plataforma.

### Para Ouvintes

Como ouvinte na plataforma, você pode:
- Explorar uma variedade de músicas de artistas independentes.
- Criar listas de reprodução e seguir seus artistas favoritos.
- Visualizar seu histórico de reprodução e descobrir novas recomendações musicais.

## Próximos Passos

- Implementar recursos adicionais com base no feedback do usuário.
- Realizar testes extensivos para confiabilidade e desempenho.
- Refinar consultas conforme necessário.
- Considerar a implementação de recursos de segurança.
- Planejar futuras melhorias e aprimoramentos.

## Contribuições

Sinta-se à vontade para contribuir para o projeto! Abra uma issue para sugestões, correções ou novos recursos.
