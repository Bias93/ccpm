# 🚀 CCPM Enhanced - Quickstart Guide

**Il Main Flow Completo: dalla tua idea grezza al codice di produzione funzionante.**

*Trasforma qualsiasi idea in un progetto strutturato e sviluppabile in meno di 60 minuti.*

---

## 🎯 Il Main Flow di CCPM

**CCPM ti guida attraverso l'intero processo di development:**

```
Idea Grezza → Validazione AI → Progetto Configurato → PRD Dettagliato → 
Epic e Tasks → AI Agents Custom → Codice Funzionante
```

**Perché questo approccio funziona:**
- ✅ **Validation-First**: Evita di costruire prodotti che nessuno vuole
- ✅ **AI-Powered**: Ricerca automatica di mercato e competitive analysis
- ✅ **Strutturato**: Da idea vaga a requirements chiari e actionable
- ✅ **Development-Ready**: Setup completo con GitHub integration
- ✅ **Custom AI Agents**: Agenti specializzati che conoscono il tuo stack

---

## 📋 Prerequisites (5 minuti)

```bash
# 1. Hai Claude Code installato?
# Se no: curl -fsSL https://claude.ai/install | sh

# 2. Hai un account GitHub?
# Se no: Vai su https://github.com/join

# 3. Clona il sistema CCPM
git clone https://github.com/your-username/ccpm-enhanced.git
cd ccpm-enhanced

# 4. Verifica che tutto funzioni
ls .claude/commands/pm/
# Dovresti vedere tutti i comandi PM disponibili

# 5. Sei pronto! Il sistema CCPM è configurato e ready to use.
```

**Setup del tuo ambiente:**
- Git configurato con il tuo nome e email
- GitHub account per hosting dei progetti
- Repository GitHub per il tuo progetto (creeremo questo insieme)

---

## 🧠 Step 1: Scrivi la Tua Idea (3 minuti)

**L'idea è il punto di partenza di tutto. Non deve essere perfetta, ma chiara.**

Crea `IDEA.md` con la tua idea grezza usando questo template:

```markdown
# Il Mio Progetto

[Descrivi la tua idea in 1-3 frasi. Anche vaga va bene!]

## Il problema che risolve
[Cosa non funziona oggi? Quale frustrazione provi tu o altri?]

## La mia soluzione
[Come risolveresti il problema? Cosa costruiresti?]

## Chi lo userebbe
[Chi sono le persone che hanno questo problema? Anche categorico va bene]

## Perché ora?
[Perché questo progetto ha senso adesso? Cosa è cambiato?]
```

**Esempi reali per ispirazione:**

<details>
<summary>📊 <strong>Expense Tracker Personale</strong></summary>

```markdown
# Expense Tracker Intelligente

App che traccia automaticamente le spese da email/SMS e categorizza tutto con AI.
Non più scontrini da inserire manualmente.

Il problema: perdere tempo a tracciare manualmente ogni spesa.
La soluzione: parsing automatico di email e notifiche di pagamento.
Chi lo usa: freelancer, piccoli business, persone che vogliono controllo finanziario.
Perché ora: AI è abbastanza buona per parsing accurato, tutti pagano digitalmente.
```
</details>

<details>
<summary>🏠 <strong>Local Service Finder</strong></summary>

```markdown
# Trova Servizi Locali Velocemente

Piattaforma per trovare idraulici, elettricisti, ecc. con recensioni vere e prezzi trasparenti.
Alternativa seria a siti pieni di spam.

Il problema: trovare professionisti locali affidabili è un incubo.
La soluzione: database curato con verifiche reali e pricing trasparente.
Chi lo usa: proprietari di casa, piccole imprese che servono servizi locali.
Perché ora: post-COVID tutti cercano servizi locali, fiducia è cruciale.
```
</details>

<details>
<summary>💡 <strong>Micro-SaaS Idea</strong></summary>

```markdown
# Newsletter Analytics per Creator

Tool che analizza performance delle newsletter e suggerisce miglioramenti automatici.
Insight actionable invece di solo numeri.

Il problema: analytics delle newsletter sono basic e non danno insight utili.
La soluzione: AI analysis di content + engagement per suggerimenti specifici.
Chi lo usa: content creator, marketer, small business con newsletter.
Perché ora: newsletter marketing sta esplodendo, creator economy in crescita.
```
</details>

**💡 Pro Tip:** Non preoccuparti se l'idea sembra banale o già fatta. La validazione nel prossimo step ti dirà se vale la pena procedere o come distinguersi.

---

## 🔍 Step 2: Validazione Automatica (15-20 minuti)

**Il momento più importante: scopri se la tua idea vale il tuo tempo PRIMA di codificare.**

```bash
# Validazione AI-powered completamente automatica
/pm:validate-idea IDEA.md
```

**💡 Perché la validazione è cruciale:**
- 🎯 **Evita mesi di lavoro** su prodotti che nessuno vuole
- 📊 **Dati reali** invece di supposizioni
- 🔍 **Scopri i competitor** che non conoscevi
- 💰 **Identifica opportunità** di business concrete
- 🚀 **Aumenta le probabilità** di successo 10x

**Cosa succede (completamente automatico - zero input da te):**

1. **🧠 Analisi Intelligente dell'Idea (2 min)**
   - Estrazione automatica di problem/solution/target
   - Generazione keywords di ricerca strategiche
   - Pianificazione ricerca competitiva

2. **🌐 Ricerca Web Massiva (15+ searches, 12 min)**
   - **Market Trend Analysis**: Volumi di ricerca, crescita, interesse
   - **Competitive Intelligence**: Scoperta competitor, analisi feature, gap di mercato
   - **Problem Validation**: Evidenza di pain point reali degli user
   - **Solution Demand**: Trend di adozione, willingness to pay

3. **📊 Scoring Automatico Lean Startup (3 min)**
   - **Market Evidence** (1-10): Dimensione mercato, crescita, demand signals
   - **Solution-Market Fit** (1-10): Gap competitivi, differenziazione possibile
   - **Business Viability** (1-10): Modelli revenue, disposizione a pagare
   - **Technical Feasibility** (1-10): Complessità implementazione, risorse necessarie

**🎯 Decisioni possibili:**

- ✅ **GO Decision** (3+ scores ≥7/10): Procedi con setup progetto
- ❌ **NO-GO Decision** (<3 scores ≥7/10): Leggi pivot opportunities e itera
- ⚠️ **MAYBE Decision** (borderline): Leggi raccomandazioni per raffinare l'idea

**📋 Output Finale:**
`VALIDATED-IDEA.md` con research completo, scoring dettagliato, e raccomandazioni strategiche.

**⏱️ Tempo reale:** 15-20 minuti (varia in base alla complessità del mercato)

---

## 🚀 Step 3: Setup Progetto (3-5 minuti)

**⚠️ Solo se validation = GO! Non sprecare tempo su idee NO-GO.**

```bash
# Setup automatico del progetto - sostituisci con il tuo nome progetto
/pm:new-project expense-tracker-smart

# Con opzioni personalizzate (se git config non è settato)
/pm:new-project expense-tracker-smart --github-user tuousername --email tua@email.com
```

**💡 Nome progetto:** 
- Solo lettere minuscole, numeri, trattini
- Es: `expense-tracker`, `newsletter-analytics`, `local-services`
- Sarà il nome del tuo repository GitHub

**Cosa succede automaticamente:**

1. **🔧 Git Configuration**
   - Rileva automaticamente la tua configurazione Git
   - Configura remote per il TUO repository GitHub  
   - Rimuove i riferimenti al repository CCPM template

2. **📁 Project Structure Setup**
   - Crea struttura directories per CCPM
   - Inizializza sistema di tracking dei PRD e Epic
   - Setup templates per documentazione

3. **🧹 Template Cleanup**
   - Rimuove file specifici del template CCMP
   - Aggiorna README con il nome del tuo progetto
   - Prepara file per il TUO progetto specifico

4. **📝 Initial Commit**
   - Crea commit iniziale con configurazione completa
   - Pronto per push su GitHub

**🎯 Risultato:** 
- Progetto Git completamente configurato
- CCPM system attivo e pronto
- Ready per push su GitHub
- Ready per creazione PRD con contesto validation

**📋 Next Step Preview:** 
Il tuo `VALIDATED-IDEA.md` verrà usato per guidare la creazione del PRD dettagliato.

---

## 📝 Step 4: PRD Creation con Brainstorming Guidato (8-12 minuti)

**Trasforma la tua idea validata in requirements chiari e actionable.**

```bash
# Brainstorming guidato che usa i dati della validazione
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
```

**💡 Cos'è un PRD e perché è importante:**
Un **Product Requirements Document** ti aiuta a:
- 🎯 Definire COSA costruire prima di HOW costruirlo
- 👥 Identificare user journey e use cases specifici  
- ✅ Creare acceptance criteria misurabili
- 🚀 Evitare feature creep e mantenere focus

**Cosa succede (sessione interattiva guidata):**

1. **🧠 Context Loading**
   - Claude analizza il tuo `VALIDATED-IDEA.md`
   - Identifica insight chiave dalla ricerca di mercato
   - Prepara domande mirate basate sui dati validation

2. **💬 Guided Brainstorming Session (5-8 min)**
   Claude ti farà domande intelligenti come:
   - *"La validation mostra gap competitivo su [feature]. Come ci distingueremo?"*
   - *"I competitor fanno X ma gli user si lamentano di Y. Come risolveremo Y?"*
   - *"Quale user journey è più critico per il success dell'app?"*
   - *"Quali metriche ci diranno se stiamo risolvendo il problem reale?"*

3. **📊 Market-Informed Requirements**
   - Integration automatica dei competitive insights
   - Requirements prioritizzati basati su validation findings
   - Success metrics derivati da market research

4. **📄 PRD Generation**
   - **Executive Summary**: Vision e value proposition
   - **Problem Statement**: Basato su validation evidence  
   - **User Stories**: Personas e journey specifici
   - **Functional Requirements**: Feature core e interazioni
   - **Non-Functional Requirements**: Performance, security, scalabilità
   - **Success Criteria**: Metriche misurabili e KPI
   - **Out of Scope**: Cosa NON stiamo facendo (mantiene focus)

**🎯 Risultato finale:**
`.claude/prds/project-foundation.md` - PRD completo, strutturato, con market context integrato.

**💡 Pro Tip:** Rispondi onestamente alle domande. Claude usa i tuoi input per creare requirements realistici e achievable.

---

## 🏗️ Step 5: Epic Planning & Custom AI Agents (6-8 minuti)

**Il bridge cruciale: da COSA (PRD) a COME (tasks + agents specializzati).**

### 5a. Technical Planning (2-3 minuti)
```bash
# Claude analizza il PRD e fa scelte tecniche intelligent
/pm:prd-parse project-foundation
```

**Cosa succede:**
- 🧠 Claude analizza i requirements del PRD
- 🛠️ **Auto-seleziona tech stack** ottimale (es: Next.js 15 + Prisma + PostgreSQL)
- 📋 Genera **technical epic** con breakdown in tasks da 1-3 giorni
- 🎯 Prioritizza tasks per dependency e business value

### 5b. AI Agents Generation (2 minuti) ✨ 
```bash
# Genera 5-7 AI agents CUSTOM per il tuo progetto specifico
/pm:agent-generate project-foundation
```

**🤖 La feature più potente di CCPM:**
Invece di generici agents, avrai specialisti che conoscono:
- 📊 **Il tuo business domain** (expense tracking, newsletter analytics, etc.)
- 🛠️ **Il tuo tech stack** esatto (Next.js, React Native, FastAPI, etc.)
- 🎯 **I tuoi requirements** specifici dal PRD
- 🏗️ **La tua architecture** e pattern scelti

**Agents generati automaticamente:**
- `{progetto}-setup-specialist` - Boilerplate e initial configuration (Haiku model)
- `{progetto}-backend-specialist` - API development, database (Sonnet model)  
- `{progetto}-frontend-specialist` - UI/UX, components, styling (Sonnet model)
- `{progetto}-data-specialist` - Database schema, migrations (Sonnet model)
- `{progetto}-testing-specialist` - Test strategy, automation (Opus model)
- `{progetto}-deployment-specialist` - CI/CD, production setup (Opus model)

### 5c. GitHub Integration (2-3 minuti)
```bash
# Crea GitHub Issues dai tasks + collega tutto insieme
/pm:epic-oneshot project-foundation
```

**Integrazione completa:**
- 🏷️ **GitHub Issues** creati automaticamente con acceptance criteria
- 📊 **Labels e milestones** per organization  
- 🔗 **Links bidirezionali**: PRD ↔ Epic ↔ Issues ↔ Future Code
- 📈 **Progress tracking** ready per development

**🎯 Risultato Finale:**
- GitHub repository con Issues actionable e prioritizzati
- AI agents customizzati che capiscono il TUO progetto
- Epic plan completo per 2-4 settimane di development
- Tech stack selezionato e architecture definita

**💡 Magic Moment:** I tuoi agents non chiederanno "che framework usi?" o "come strutturi il database?" - lo sanno già!

---

## 💻 Step 6: Deploy & Start Development (3-5 minuti setup + ongoing)

**Ora il divertimento inizia: dai requirements al codice funzionante.**

### 6a. Deploy su GitHub (2 minuti)
```bash
# STEP CRITICO: Crea prima il repository su GitHub
# Vai su https://github.com/new e crea repository con lo stesso nome del progetto
# NON inizializzare con README (già presente)

# Poi fai push del progetto configurato
git push -u origin main
```

### 6b. Prime Development Environment (1 minuto)
```bash
# Carica il context completo del progetto in Claude
/context:prime

# Mostra il prossimo task prioritario  
/pm:next
```

### 6c. Start Development Loop (ongoing)
```bash
# Inizia a lavorare su un issue specifico
/pm:issue-start 1

# Claude userà automaticamente l'agent specialist giusto!
```

**🚀 Il Development Flow Optimized:**

1. **🎯 Context-Aware Development**
   - `/context:prime` carica: PRD, epic, validation data, tech decisions
   - Claude conosce business logic, user stories, acceptance criteria
   - Niente "reminder" necessario - il contesto è persistente

2. **🤖 Intelligent Agent Delegation**  
   - CCPM automatically seleziona l'agent giusto per il task
   - Backend task → `{progetto}-backend-specialist`
   - Frontend task → `{progetto}-frontend-specialist`
   - Database task → `{progetto}-data-specialist`

3. **📈 Automatic Progress Tracking**
   - Codice committato automaticamente
   - GitHub Issues aggiornati con progress  
   - Branch/PR workflow se configurato

4. **✅ Quality Built-In**
   - Test scritti insieme al codice
   - Code review automatico con best practices
   - Documentation aggiornata incrementalmente

**🎯 Risultati Concreti dal Primo Task:**
- ✅ **Codice funzionante** che soddisfa acceptance criteria
- ✅ **Test automatici** per validare functionality
- ✅ **Documentation** per future maintenance  
- ✅ **GitHub sync** con progress tracciato
- ✅ **Ready per next task** senza context loss

**💡 Pro Tips per Development:**
- Usa `/pm:next` per vedere next priority task
- `/pm:issue-sync` per aggiornare GitHub se necessario
- `/pm:standup` per daily status overview
- Trust degli agents - hanno context completo del progetto

---

## 🎯 Complete CCPM Workflow - Zero to Production 

**Il workflow completo che ti porta da idea grezza a codice funzionante in ~45-60 minuti di setup + development ongoing.**

### 🚀 Quick Command Reference
```bash
# WORKFLOW COMPLETO - Copy & Paste Ready

# STEP 1: Scrivi l'idea (3 min)
cat > IDEA.md << 'EOF'
# Expense Tracker Intelligente

App che traccia automaticamente le spese da email/SMS con AI.

Il problema: perdere tempo a tracciare manualmente ogni spesa.
La soluzione: parsing automatico di email e notifiche.
Chi lo usa: freelancer, piccoli business, controllo finanziario.
Perché ora: AI parsing accurato, tutti pagano digitalmente.
EOF

# STEP 2: Validazione automatica (15-20 min)
/pm:validate-idea IDEA.md
# → Attendi GO/NO-GO decision

# STEP 3: Setup progetto SE GO (3-5 min)
/pm:new-project expense-tracker-smart

# STEP 4: PRD con brainstorming guidato (8-12 min) 
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
# → Rispondi alle domande di Claude per creare PRD completo

# STEP 5: Planning + Custom Agents (6-8 min)
/pm:prd-parse project-foundation        # Tech stack selection
/pm:agent-generate project-foundation   # Custom AI agents
/pm:epic-oneshot project-foundation     # GitHub Issues

# STEP 6: Deploy & Start Development (3-5 min setup)
# Vai su https://github.com/new - crea repo "expense-tracker-smart"
git push -u origin main
/context:prime
/pm:issue-start 1

# 🎉 DONE! Your project is live with custom AI agents ready to code.
```

### ⏱️ Tempo Breakdown Realistico
- **Step 1** (Idea): 3 minuti ✏️
- **Step 2** (Validation): 15-20 minuti 🤖 (completamente automatico)
- **Step 3** (Setup): 3-5 minuti ⚙️
- **Step 4** (PRD): 8-12 minuti 💬 (brainstorming interattivo)
- **Step 5** (Planning): 6-8 minuti 📋 (automatico con interaction)
- **Step 6** (Deploy): 3-5 minuti 🚀

**⏱️ Totale Setup: 38-53 minuti** 
**✨ Development: ongoing con custom AI agents**

---

## 🤖 Custom AI Agents: Il Game-Changer di CCPM

**La differenza tra CCPM e altri tool: Agents che conoscono IL TUO progetto specifico.**

### Cosa Rende Speciali i Custom Agents

**Problema con generic AI agents:**
- "Che framework stai usando?" 🙄
- "Come hai strutturato il database?" 🤔  
- "Quali sono i requirements?" 😕
- Perdite di tempo continue per re-spiegare il context

**La soluzione CCPM:**
I tuoi agents custom nascono **già sapendo tutto** del tuo progetto:

```bash
# Genera 5-7 agents SPECIALIZZATI nel tuo progetto
/pm:agent-generate project-foundation
```

### 🧠 Cosa Sanno i Tuoi Custom Agents

**Business Context:**
- 📊 Il problema che stai risolvendo (dal VALIDATED-IDEA.md)
- 👥 I tuoi target users e use cases (dal PRD)  
- 🎯 Success metrics e acceptance criteria
- 🏆 Competitive advantages identificati nella validation

**Technical Context:**
- 🛠️ **Stack completo**: Framework, database, hosting, tools
- 🏗️ **Architecture patterns**: come organizzi il codice
- 📋 **Coding standards**: naming conventions, structure
- 🧪 **Testing approach**: strategy, frameworks, coverage

**Project Context:**
- 📁 **File structure** e organization
- 📝 **Current progress** e next priorities  
- 🔗 **Dependencies** tra componenti
- 🚀 **Deployment strategy** e environment setup

### 🎯 Agents Generati Automaticamente

**Setup & Architecture:**
- `{progetto}-setup-specialist` - Boilerplate, configuration, initial structure (Haiku)
- `{progetto}-architect` - System design, patterns, scalability decisions (Opus)

**Development Specialists:**
- `{progetto}-backend-specialist` - API development, business logic, integrations (Sonnet)
- `{progetto}-frontend-specialist` - UI/UX, components, state management (Sonnet)  
- `{progetto}-data-specialist` - Database schema, queries, migrations (Sonnet)
- `{progetto}-mobile-specialist` - Native features, performance, app stores (Sonnet) *[se mobile app]*

**Quality & Deployment:**
- `{progetto}-testing-specialist` - Test strategy, automation, quality assurance (Opus)
- `{progetto}-deployment-specialist` - CI/CD, production setup, monitoring (Opus)

### 🚀 Tech Stack Auto-Selection

**Basato sui tuoi requirements, CCPM seleziona intelligently:**

**Web Applications:**
- **Fullstack SaaS** → Next.js 15 + Prisma + PostgreSQL + Vercel
- **Landing Page** → Next.js + Tailwind + MDX + Vercel  
- **Dashboard/Admin** → Next.js + Tailwind + React Query + Supabase

**Mobile Applications:**
- **Cross-platform** → React Native + Expo + TypeScript
- **Native iOS** → Swift + SwiftUI + Core Data
- **PWA** → Next.js + Workbox + App Manifest

**Backend Services:**
- **REST API** → Fastify + Prisma + PostgreSQL + Docker
- **GraphQL API** → Apollo Server + Prisma + PostgreSQL  
- **Serverless** → Vercel Functions + Prisma + PlanetScale

### 💡 The Magic in Action

**Before CCMP (typical AI conversation):**
```
You: "Help me implement user authentication"
AI: "What framework are you using?"
You: "Next.js with Prisma"  
AI: "What authentication method do you prefer?"
You: "JWT with email/password"
AI: "What's your database schema?"
[10 more back-and-forth questions...]
```

**With CCPM Custom Agents:**
```
You: "Implement user authentication"
expense-tracker-backend-specialist: "I'll implement JWT auth with email/password for your expense tracker, integrating with your Prisma User model and following your established API patterns. Creating auth middleware, registration/login endpoints, and password hashing..."
[Starts coding immediately]
```

**🎯 Result:** 10x faster development, zero context switching, perfect consistency.

---

## 📊 Success Checkpoints: Come Sapere se Stai Andando Bene

**Ogni step ha criteri di success chiari. Se non li soddisfi, fermati e correggi prima di procedere.**

### ✅ Step 1 Success (Idea Writing)
**Green Light Criteria:**
- ✅ Hai scritto almeno 3-4 frasi per ogni sezione dell'IDEA.md
- ✅ Il problema è chiaro e relatable  
- ✅ La soluzione è specifica, non generica
- ✅ Conosci chi userebbe il prodotto

**🚨 Red Flags:**
- ❌ "Rivoluzionerà tutto" - troppo vago
- ❌ Nessun problema specifico identificato
- ❌ "Tutti" come target user

### ✅ Step 2 Success (Validation - CRITICAL GATE)
**Green Light Criteria:**
- ✅ **GO Decision** con confidence ≥7/10
- ✅ Market evidence trovato (search volume, pain points)
- ✅ Competitive gaps identificati chiaramente
- ✅ Business viability confermata (willingness to pay)

**🚨 Red Flags che richiedono pivot:**
- ❌ **NO-GO Decision** - STOP, leggi pivot opportunities
- ❌ Market saturo senza differenziazione possibile
- ❌ No evidence di problema reale negli users
- ❌ Complessità tecnica troppo alta per solo dev

**💡 Action on NO-GO:** Non procedere! Usa le pivot opportunities per raffinare l'idea.

### ✅ Step 3 Success (Project Setup)
**Green Light Criteria:**
- ✅ Git remote configured correttamente 
- ✅ Repository name match project name
- ✅ CCPM directories e files presenti (`.claude/` structure)
- ✅ Initial commit successful

**🚨 Red Flags:**
- ❌ Git remote ancora punta a CCPM template
- ❌ Directory `.claude/` mancante o incompleta  
- ❌ Errori di git config (nome/email)

### ✅ Step 4 Success (PRD Creation)  
**Green Light Criteria:**
- ✅ PRD file generato: `.claude/prds/project-foundation.md`
- ✅ Tutte le sections presenti e popolate (no placeholder text)
- ✅ User stories con acceptance criteria chiari
- ✅ Success metrics sono measurable
- ✅ Validation data integrati nel PRD

**🚨 Red Flags:**
- ❌ Sections vuote o con placeholder text
- ❌ User stories troppo vaghe ("User può fare cose")
- ❌ Success metrics non misurabili ("App sarà popolare")

### ✅ Step 5 Success (Planning & Agents)
**Green Light Criteria:**
- ✅ Tech stack selezionato e documentato
- ✅ Epic breakdown in tasks da 1-3 giorni maximum
- ✅ 5-7 custom agents generati con nomi project-specific
- ✅ GitHub Issues creati automaticamente
- ✅ Tasks hanno acceptance criteria chiari

**🚨 Red Flags:**
- ❌ Tasks troppo grandi (>3 giorni)
- ❌ Generic agents invece che custom per progetto
- ❌ GitHub Issues mancanti o malformattati
- ❌ Dependencies tra tasks non chiare

### ✅ Step 6 Success (Development Start)
**Green Light Criteria:**
- ✅ Repository pushed successfully su GitHub
- ✅ `/context:prime` loaded project context
- ✅ First task started con agent appropriato
- ✅ Code che soddisfa acceptance criteria del task
- ✅ Progress tracked su GitHub

**🚨 Red Flags:**
- ❌ Push failed (repository non configurato correttamente)
- ❌ Context loading failed (CCPM structure problems)
- ❌ Agent non sa il project context
- ❌ Code non align con requirements PRD

### 🎯 Overall Project Health Check

**🟢 Everything is Green se hai:**
- Market-validated idea (GO decision)
- Comprehensive PRD con market context  
- Custom AI agents che conoscono il tuo progetto
- GitHub workflow attivo con progress tracking
- Code che soddisfa business requirements

**🔴 Stop and Fix se hai:**
- NO-GO validation (pivot required)
- Vague requirements o acceptance criteria
- Generic agents senza project knowledge
- Code che non riflette PRD requirements

---

## ⚡ Alternative Flow: Rapid Prototyping (Skip Validation)

**Per sperimentazione veloce quando non ti serve market validation.**

### 🚀 Quick Start (25 minuti)
```bash
# SKIP validation - direttamente al setup
/pm:new-project my-prototype

# PRD dalla raw idea (senza validation data)  
/pm:prd-new experiment --from-idea IDEA.md
# → Brainstorming meno approfondito, focus su technical feasibility

# Planning e agents
/pm:prd-parse experiment
/pm:agent-generate experiment  
/pm:epic-oneshot experiment

# Deploy e start
git push -u origin main
/context:prime
/pm:issue-start 1
```

### 🎯 Quando Usare Quick Flow

**✅ Perfect for:**
- **Technical experiments**: Testing new tech stack o library
- **Feature prototypes**: Proof of concept per feature esistenti
- **Learning projects**: Imparare nuove technologies
- **Side projects**: Fun projects senza business intent
- **Client demos**: Quick mock-up per mostrare concept

**❌ Avoid for:**
- **Business projects**: Qualsiasi cosa che intendi monetizzare
- **Serious MVPs**: Prodotti che vuoi lanciare sul mercato  
- **Client work**: Progetti per clienti che pagano
- **Startup ideas**: Anything con potential commercial value

### ⚠️ Trade-offs da Considerare

**Pro del Quick Flow:**
- ⏱️ Setup 50% più veloce (25 vs 45 minuti)
- 🧪 Perfect per technical experimentation
- 🎯 Focus puro sulla implementation
- 📚 Great learning experience

**Contra del Quick Flow:**
- 💸 **Zero market insight** - potrebbe essere inutile
- 🎯 **No competitive intelligence** - reinventi cose esistenti
- 📊 **No success metrics** - non sai se funziona
- 🛣️ **No strategic direction** - requirements superficiali

### 💡 Best Practice: Validate Later

Se il prototype sembra promising:
```bash
# Add validation to existing prototype
/pm:validate-idea REFINED-IDEA.md
# → Get market data + competitive intelligence  

# Iterate PRD with validation insights
# Update agents con market context
# Refocus development con strategic direction
```

### 🎯 When Quick Flow Actually Makes Sense

**Example scenarios:**
- *"Voglio imparare Rust - farò un CLI tool"* ✅
- *"Testo questa library React per vedere come funziona"* ✅ 
- *"Prototipo una feature per il mio prodotto esistente"* ✅
- *"Demo per cliente - concept visivo"* ✅

**But NOT:**
- *"Idea di startup - marketplace locale"* ❌ Use full validation
- *"App che farà soldi - expense tracking"* ❌ Use full validation
- *"Rimpiazzo per tool esistente ma better"* ❌ Use full validation

---

## 🔄 Daily Development Workflow: Mantieni il Momentum

**La routine ottimizzata per solo developers che garantisce progress costante.**

### 🌅 Morning Routine (2 minuti)
```bash
# 1. Context loading - Claude sa dove sei arrivato
/context:prime
# → Carica: PRD, epic, progress, validation context, tech decisions

# 2. Daily standup - overview delle priorità  
/pm:standup
# → Shows: yesterday progress, today priorities, any blockers

# 3. Next task identification
/pm:next  
# → Shows: highest priority task ready to start
```

### 💻 Development Loop (ongoing)
```bash
# Start working on specific task
/pm:issue-start 23
# → Custom agent loads task context, starts implementation

# [Work with Claude on the task using custom agents]
# Your expense-tracker-backend-specialist knows:
# - Business requirements from PRD
# - Database schema decisions  
# - API patterns established
# - Testing strategy in place

# Sync progress periodically (optional - auto-synced at commit)
/pm:issue-sync
# → Updates GitHub with current progress
```

### 🌅 End-of-Day Review (1 minuto)
```bash
# Project status overview
/pm:status
# → Shows: completion percentage, next priorities, potential blockers

# Optional: Plan tomorrow's focus
/pm:next
# → Preview tomorrow's priority tasks
```

### 🎯 Advanced Daily Commands

**When you need deeper insight:**
```bash
# Epic-level progress review  
/pm:epic-status project-foundation
# → Shows progress across all epic tasks

# If you're blocked on something
/pm:blocked "Waiting for API key from service"
# → Logs blocker, suggests alternative tasks

# Multi-task coordination (advanced)
/pm:epic-refresh project-foundation  
# → Re-prioritizes tasks based on current progress
```

### 🔄 Weekly/Milestone Workflow

**Every Friday or end of major feature:**
```bash
# Complete comprehensive sync
/pm:sync
# → Full GitHub sync, documentation updates

# Review epic progress and next phase planning
/pm:epic-status project-foundation

# Consider validation refresh (especially for longer projects)
# Has market changed? New competitors?
/pm:validate-idea UPDATED-IDEA.md
```

### ⚡ Context Optimization Tips

**🧠 Why `/context:prime` is crucial:**
- Your custom agents need project context to be effective
- Without it: agents ask basic questions, lose efficiency
- With it: agents start working immediately with full knowledge

**📊 Why daily `/pm:standup`:**
- Keeps you focused on business priorities vs interesting technical tangents
- Shows if you're on track for user value delivery  
- Identifies blockers before they become serious problems

**🎯 Why `/pm:next` matters:**
- Prevents choice paralysis on complex projects
- Ensures work aligns with business value prioritization
- Maintains momentum even when feeling stuck

### 🚫 Anti-Patterns to Avoid

**❌ Don't:**
- Skip `/context:prime` - your agents will be ineffective
- Work on random tasks - breaks epic coherence
- Ignore blockers - problems compound over time
- Skip progress updates - lose GitHub coordination benefits

**✅ Do:**
- Trust the priority system - it's based on business value + dependencies
- Communicate with agents about blockers - they can suggest alternatives
- Sync regularly - keeps project coordination tight
- Celebrate small wins - each completed task moves toward user value

---

## 🚨 Common Issues & Quick Fixes

**La troubleshooting guide per risolvere velocemente i problemi più comuni.**

### 🔴 Validation Issues

#### ❌ NO-GO Decision - "La mia idea è stata bocciata!"

**📊 Cosa significa esattamente:**
- Market size insufficiente per solo developer (<1K potential users)
- Competitive saturation con no differentiation possible
- Technical complexity troppo alta per resources available
- No evidence di willingness to pay per la solution

**🔧 Action Plan:**
1. **Non ignorare il NO-GO** - trust the data  
2. **Read "Pivot Opportunities"** in VALIDATED-IDEA.md attentamente
3. **Consider suggested alternatives:**
   - Narrow down il target market (es: "expense tracking" → "expense tracking per freelancer")
   - Change approach angle (es: "AI summarizer" → "AI meeting notes per small teams")
   - Focus on different pain point dello stesso domain
4. **Update IDEA.md** based on pivot suggestion
5. **Re-run validation** con refined idea
6. **NEVER skip validation** - temptation is high ma avoiding waste è crucial

#### ⚠️ MAYBE Decision - "È borderline"

**💭 Cosa significa:**
- Some scores good (≥7) ma others concerning (<6)
- Market exists ma differentiation strategy unclear
- Technical feasibility OK ma business model questions

**🔧 Action Plan:**
- **Proceed with caution**: Go to setup ma pay attention to weak areas
- **Focus PRD brainstorming** on addressing weak scores
- **Plan validation refresh** after building MVP
- **Consider market entry strategy** carefully

### 🔴 Setup & Technical Issues

#### ❌ "Git Push Failed"

**Common errors:**
```bash
# Error: remote repository doesn't exist
git push -u origin main
# → fatal: repository 'https://github.com/username/project-name.git' not found
```

**🔧 Fix:**
1. **Create GitHub repo first**: https://github.com/new
2. **Match names exactly**: GitHub repo name = project name da `/pm:new-project`
3. **Don't initialize with README** - CCPM ha già created initial commit
4. **Then push**: `git push -u origin main`

#### ❌ "Context Loading Failed"

**Error symptoms:**
- Custom agents ask basic questions about your project
- `/context:prime` non trova project data
- Agents don't know your tech stack

**🔧 Fix:**
1. **Check CCPM structure**: `ls -la .claude/` should show `prds/`, `agents/`, commands structure
2. **Verify PRD exists**: `ls .claude/prds/` should show `project-foundation.md`
3. **Re-run setup if missing**: `/pm:new-project project-name`
4. **Re-generate agents**: `/pm:agent-generate project-foundation`

#### ❌ "Tasks Too Big" 

**Symptoms:**
- GitHub Issues represent weeks of work
- Acceptance criteria troppo vague
- Can't estimate completion realistically

**🔧 Fix:**
1. **Manual breakdown**: Manually split large issues in GitHub
2. **Target granularity**: Each task should be 1-3 days maximum
3. **Better acceptance criteria**: Each task should have 3-5 specific criteria
4. **Re-run epic planning**: `/pm:epic-refresh project-foundation` if needed

### 🔴 Development Flow Issues

#### ❌ "Agents Don't Understand My Project"

**Symptoms:**
- Agents ask "what framework are you using?"
- Code suggestions don't match your architecture
- No awareness of business requirements

**🔧 Root causes & fixes:**
1. **Context not loaded**: Run `/context:prime` at session start
2. **Generic agents used**: Should see `{project-name}-specialist` agents, not generic ones
3. **Custom agents not generated**: Re-run `/pm:agent-generate project-foundation`
4. **PRD incomplete**: Agents derive context from PRD - if vague, they're vague

#### ❌ "Lost Track of Priorities"

**Symptoms:**
- Not sure which task to work on next
- Working on interesting tech debt instead of user value
- GitHub Issues out of sync with actual progress

**🔧 Fix:**
1. **Daily routine**: `/context:prime` → `/pm:standup` → `/pm:next` ogni morning
2. **Trust the system**: `/pm:next` shows business-value-prioritized task
3. **Sync regularly**: `/pm:issue-sync` to keep GitHub updated
4. **Epic review**: `/pm:epic-status project-foundation` per overall picture

### 🔴 GitHub Integration Issues

#### ❌ "Issues Not Created" or "Malformed Issues"

**🔧 Fix:**
1. **Re-run epic creation**: `/pm:epic-oneshot project-foundation`
2. **Check permissions**: GitHub token needs repo write access
3. **Manual creation**: If automation fails, copy issue templates from epic file

### 💡 Pro Troubleshooting Tips

**🔍 When things go wrong:**
1. **Check prerequisites first** - Git config, GitHub access, CCPM structure
2. **Read error messages carefully** - CCPM gives specific guidance
3. **Re-run commands** - Most issues fixed by re-running setup/generation commands  
4. **Don't skip steps** - Each step builds on previous ones
5. **Trust the validation** - NO-GO decisions save you weeks of wasted work

---

## 💡 Pro Tips: Master CCPM Like a Pro

**Advanced techniques per massimizzare efficiency e results.**

### 🎯 Strategic Tips

1. **🔥 Validation is Your Superpower**  
   - 15-20 minuti di research automated ti save settimane di development su idee wrong
   - Trust NO-GO decisions - resistance è natural ma data doesn't lie
   - Use pivot opportunities creativamente - spesso sono better than original idea

2. **📊 Leverage Market Context Throughout**
   - PRD informed da validation è 10x più strategic
   - Reference competitive gaps durante development per differentiation
   - Use validation findings per guide feature prioritization

3. **🤖 Custom Agents Are Game-Changers**
   - Context-aware agents eliminate 80% del prompt engineering
   - Each agent knows business logic, tech stack, user requirements  
   - Trust agent suggestions - they're based on your PRD + market data

4. **🔄 Context is King**
   - Always `/context:prime` all'inizio di ogni development session
   - Context loss kills efficiency - custom agents become generic
   - Maintain daily routine: prime → standup → next task

### 🚀 Tactical Optimization  

5. **📋 Trust the Priority System**
   - `/pm:next` shows business-value-optimized tasks, not tech-debt rabbit holes
   - Resist urge to work on "interesting" tasks vs high-impact ones
   - Business value primeiro, technical perfection secondo

6. **🎯 MVP Mindset Always**
   - Ship smallest viable version of each feature
   - User feedback beats internal polish 
   - Iterate based on actual usage, not assumptions

7. **📈 Progress Visibility**
   - Keep GitHub updated - shows progress to stakeholders/yourself
   - Daily standup highlights blockers before they become serious
   - Epic-level view prevents losing big picture

8. **🔧 Fix Problems Early**
   - Re-run commands when things feel off (setup, agent generation, etc.)
   - Don't work around broken config - fix root causes
   - CCPM works best when all components are aligned

### 🧠 Mental Model Tips

9. **🎮 Think in Phases**
   - **Phase 1**: Validation → Setup → PRD (business clarity)
   - **Phase 2**: Planning → Agents (technical preparation)  
   - **Phase 3**: Development → Iteration (execution)
   - Don't rush phases - each builds foundation for next

10. **📊 Data-Driven Decisions**
    - Validation provides market evidence - use it per decisions
    - Success metrics in PRD guide development priorities
    - Regular validation refresh per long projects (market changes)

### ⚡ Efficiency Hacks

11. **📁 Template Your Success**
    - Successful IDEA.md structure → template for future ideas
    - Good PRD patterns → reuse structure
    - Effective agent configurations → document for similar projects

12. **🔄 Iterate the Process**
    - After each project completion, note what worked/didn't
    - Refine your personal idea → validation → PRD workflow
    - CCPM is flexible - adapt to your style

---

## 📊 Success Metrics: Know You're Winning

### 🎯 Validation Phase Success
- ✅ **GO decision** with confidence ≥8/10  
- ✅ **Competitive differentiation** clearly identified (not just "we'll be better")
- ✅ **Market size** adequate for solo dev (≥1,000 potential users)
- ✅ **Business model** evidence (willingness to pay signals)

### ⚡ Setup Phase Success  
- ✅ **Total setup time** ≤60 minuti (from IDEA.md to first code commit)
- ✅ **GitHub integration** working (issues created, progress trackable)
- ✅ **Custom agents** generated con project-specific knowledge
- ✅ **Tech stack** selected e documented

### 🚀 Development Phase Success
- ✅ **Context preservation** - agents know your project without re-explaining
- ✅ **Task completion rate** - 1-3 day tasks completed on schedule
- ✅ **Business alignment** - code satisfies PRD requirements  
- ✅ **Quality built-in** - tests, documentation, best practices automatic

### 🏆 Project Success Indicators

**Early Success (First 2 weeks):**
- 🎯 Core user journey implemented e testable
- 📊 First success metric measurable 
- 🔄 Development velocity established

**MVP Success (4-6 weeks):**
- 👥 Real users can complete primary use case
- 📈 Success metrics show positive user behavior
- 🚀 Deployment pipeline functional

**Long-term Success (3+ months):**
- 📊 Validation predictions proved accurate  
- 💰 Business model validation (if commercial intent)
- 🔄 Feature iteration driven by user feedback

---

## 🎊 Ready to Transform Your Ideas?

> **The CCPM Philosophy:** 
> 
> ✅ **Evidence over assumptions** - Market data guides decisions
> 
> ✅ **Structure over chaos** - Clear process from idea to production
> 
> ✅ **AI-powered efficiency** - Custom agents eliminate friction
> 
> ✅ **Solo developer optimized** - Built for builders working independently

**Your next breakthrough idea is one validation away. Start with Step 1! 🚀**

---

*Built for solo developers who ship. Happy building! 💻✨*