# Gintleman - Premium Gin Shop

Gintleman è un'applicazione web basata su Java dedicata alla vendita di gin premium. La piattaforma offre un'esperienza e-commerce raffinata per gli appassionati di gin, con un catalogo curato, gestione account utente e una dashboard di amministrazione.

## 🌟 Funzionalità

### Funzionalità Utente

- **Catalogo Prodotti**: Naviga tra un'ampia selezione di gin con opzioni di filtro (Nazionalità, Prezzo, ecc.).
- **Dettagli Prodotto**: Pagine dettagliate per ogni prodotto con descrizione, informazioni sull'origine e funzionalità "Aggiungi al Carrello".
- **Carrello**: Gestisci gli articoli, aggiorna le quantità e procedi al checkout.
- **Account Utente**: Sistema di Registrazione e Login.
  - **Dashboard**: Visualizza il profilo personale e lo storico degli ordini.
- **Processo di Checkout**: Flusso di pagamento sicuro con convalida dell'indirizzo (simulata).
- **Design Responsivo**: Ottimizzato per dispositivi Desktop, Tablet e Mobile.

### Funzionalità Amministratore

- **Dashboard**: Panoramica dello stato della piattaforma.
- **Gestione Prodotti**: Aggiungi, modifica e aggiorna i dettagli dei prodotti (Stock, Prezzo, Descrizione, ecc.).
- **Gestione Ordini**: Visualizza tutti gli ordini dei clienti e il loro stato.

## 🛠 Stack Tecnologico

- **Backend**: Java 23, Jakarta Servlet 6.1.0
- **Frontend**: JSP (JavaServer Pages), JSTL 3.0.0, HTML5, CSS3, JavaScript (Vanilla)
- **Database**: MySQL 9.1.0
- **Strumento di Build**: Maven
- **Server**: Apache Tomcat 10.1+ (raccomandato) o Container Servlet compatibile

## 📂 Struttura del Progetto

Il progetto segue il pattern architetturale **MVC (Model-View-Controller)**:

- **`src/main/java/model`**: Java Beans e DAO (Data Access Objects) per l'interazione con il database.
- **`src/main/java/control`**: Servlet che gestiscono le richieste HTTP e la logica di business.
- **`src/main/webapp`**:
  - **File JSP**: Template delle viste (Pagine come `index.jsp`, `catalog.jsp`, ecc.).
  - **`css/`**: Fogli di stile per pagine specifiche e layout responsivi.
  - **`js/`**: Script lato client.
  - **`img/`**: Asset e immagini dei prodotti.

## 🚀 Configurazione e Installazione

### Prerequisiti

- JDK 23 o superiore
- Apache Maven
- MySQL Server
- IDE (IntelliJ IDEA raccomandato) con integrazione Tomcat

### Configurazione Database

1.  Crea un database MySQL chiamato `gintleman`.
2.  Importa lo schema/dati utilizzando lo script SQL fornito: `Database/gintleman_db.sql`.
3.  Configura la connessione al database in `src/main/java/model/DriverManagerConnectionPool.java`.

### Esecuzione dell'Applicazione

1.  Clona il repository.
2.  Apri il progetto nel tuo IDE.
3.  Compila il progetto usando Maven:
    ```bash
    mvn clean install
    ```
4.  Esegui il deploy del file WAR generato sul tuo server Tomcat.
5.  Accedi all'applicazione su `http://localhost:8080/Gintleman`.

## 👨‍💻 Crediti

Sviluppato da **Gianpaolo**.
_Fatto con 💚 per gli amanti del Gin._
