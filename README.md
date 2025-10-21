# Planty

Aplicação IOT focado em **gerenciamento de plantas**, cuidado e monitoramento — desenvolvido para quem ama jardinagem e quer ter suas plantas sempre saudáveis.
**NECESSÁRIO POSSUIR ARDUINO E COMPONENTES**
---

<img width="904" height="804" alt="image" src="https://github.com/user-attachments/assets/6b52b2e4-4c08-415d-a286-49fb901ca8f6" />


## 🎯 Visão Geral

O Planty permite que o usuário organize suas plantas, registre seu ciclo de cuidados (rega, adubação, poda), receba lembretes personalizados e visualize o histórico de saúde da planta.  
Ideal tanto para quem está começando no mundo da jardinagem quanto para jardineiros experientes.

---

## 🧩 Funcionalidades Principais

- ✅ Cadastro de plantas (nome, espécie, foto, local)  
- 🗓️ Registro de eventos de cuidados: rega, adubação, poda, transplante  
- 🔔 Notificações/alertas para condições de temperatura, umidade do solo, e luminosidade ao longo dos dias.

---

## ⚙️ Tecnologias Utilizadas

- **Frontend**: Flutter (Dart) — desenvolvimento móvel multiplataforma  
- **Backend/APIs**: ASP.NET Core 8  
- **Banco de Dados**: PostgreSQL  
- **Bibliotecas de estado e UI**: conforme definidas no `pubspec.yaml`

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- SDK da tecnologia escolhida instalada (ex: Flutter ou Node.js)  
- Emulador de dispositivo móvel ou dispositivo real para testes  
- Git  

### Passos

```bash
# Clone o repositório
git clone https://github.com/lazarobodevan/planty.git

# Acesse a pasta do projeto
cd planty

# Instale as dependências
flutter pub get

# Execute o app
flutter run

# Instale o script do Arduino na placa - comunicação serial
