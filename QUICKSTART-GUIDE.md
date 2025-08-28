# 🚀 CCPM Enhanced - Quickstart Guide

**Validation-First Workflow: dalla tua idea grezza al primo commit in 30 minuti.**

---

## 📋 Prerequisites (2 minuti)

```bash
# 1. Installa Claude Code (se non lo hai già)
# 2. Clona questo sistema 
git clone https://github.com/your-username/ccpm-enhanced.git
cd ccpm-enhanced

# 3. Sei pronto! Il sistema CCPM è già configurato.
```

---

## 🧠 Step 1: Scrivi la Tua Idea (2 minuti)

Crea `IDEA.md` con la tua idea grezza:

```markdown
# My Project Idea

[Scrivi qui la tua idea - anche poche righe vanno bene]

Il problema che risolve:
[Cosa non funziona oggi?]

La mia soluzione:
[Come lo risolveresti?]

Chi lo userebbe:
[Target users - anche generici]
```

**Esempio reale (usando TEST-IDEA.md):**
```markdown
# AI Summarizer

Sito dove inserisci link/testi e l'AI li riassume e organizza.
Crea una knowledge base personale ricercabile.

Il problema: troppo contenuto, poco tempo per organizzarlo.
La soluzione: AI che riassume e categorizza automaticamente.
Chi lo usa: knowledge workers, studenti, ricercatori.
```

---

## 🔍 Step 2: Validazione Automatica (18 minuti)

```bash
# Validazione PRIMA del setup - evita sprechi di tempo
/pm:validate-idea IDEA.md
```

**Cosa succede (completamente automatico):**
- ✅ 15+ ricerche web su mercato e competitor
- ✅ Analisi competitive gaps e opportunità
- ✅ Scoring automatico lean startup (1-10)
- ✅ **Decisione GO/NO-GO** con confidence level
- ✅ Output: `VALIDATED-IDEA.md` completo

**Decisioni possibili:**
- **GO** → Continua con setup progetto
- **NO-GO** → Leggi pivot opportunities, modifica idea, riprova

---

## 🚀 Step 3: Setup Progetto (2 minuti)

**⚠️ Solo se validation = GO!**

```bash
# Setup progetto (SOLO setup, non genera PRD)
/pm:new-project ai-summarizer
```

**Cosa succede (automaticamente):**
- ✅ **Git setup completo** - Remote, user config, initial commit
- ✅ **CCPM initialization** - Sistema PM configurato  
- ✅ **Project structure** - Directory e configurazione
- ✅ **GitHub ready** - Pronto per push su tuo repository

**Risultato:** Progetto configurato e pronto per PRD creation.

---

## 📝 Step 4: Comprehensive PRD Creation (10 minuti)

```bash
# Brainstorming guidato usando validation data
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
```

**Cosa succede (interattivamente):**
- 🧠 **Claude guided brainstorming** - Domande mirate per approfondire
- 💡 **Market-informed questions** - Basate su competitive analysis  
- 🎯 **Comprehensive PRD** - User journeys, acceptance criteria, success metrics
- 📊 **Validation integration** - Market context popolato da research

**Risultato:** `.claude/prds/project-foundation.md` completo e dettagliato.

---

## 🏗️ Step 5: Epic e Task Planning (2 minuti)

```bash
# Trasforma PRD in epic e GitHub Issues
/pm:prd-parse project-foundation
/pm:epic-oneshot project-foundation
```

**Cosa succede:**
- 📋 Epic breakdown in task da 1-3 giorni
- 🏷️ GitHub Issues creati automaticamente
- 🔗 Link tra PRD → Epic → Issues → Code
- 📈 Progress tracking setup

**Risultato:** GitHub Issues pronti per development.

---

## 💻 Step 6: Start Development (Immediate)

```bash
# Push to GitHub e inizia development
git push -u origin main

# Priming del contesto per Claude
/context:prime
/pm:next
/pm:issue-start <issue-number>
```

**Cosa succede:**
- 🤖 Agent specializzato lavora sul task
- 📁 Context mantenuto attraverso sessioni
- ✅ Progress automatico su GitHub
- 🔄 Parallel execution quando possibile

**Risultato:** Codice funzionante, test, documentazione.

---

## 🎯 Workflow Completo Ottimizzato

```bash
# VALIDATION-FIRST + SEPARATION OF CONCERNS
# Tempo totale: 32 minuti setup + development

# 1. Scrivi idea (2 min)
echo "# AI Summarizer

Sito per riassumere contenuti con AI.
Knowledge base ricercabile." > IDEA.md

# 2. Validazione PRIMA di setup (18 min) 
/pm:validate-idea IDEA.md
# → VALIDATED-IDEA.md con GO/NO-GO decision

# 3. SE GO: Setup progetto (2 min)
/pm:new-project ai-summarizer  
# → Project setup ONLY (no PRD)

# 4. Comprehensive PRD creation (10 min)
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
# → Brainstorming guidato + PRD dettagliato

# 5. Epic e GitHub Issues (2 min)
/pm:prd-parse project-foundation
/pm:epic-oneshot project-foundation

# 6. Push e development
git push -u origin main
/context:prime && /pm:next && /pm:issue-start 1
```

---

## 📊 Success Gates

**After Step 2 (Validation - CRITICAL GATE):**
- ✅ **GO Decision** → Continue with setup  
- ❌ **NO-GO Decision** → Read pivot opportunities, iterate idea
- 📊 **Market size validated** and competitive gaps identified
- 🎯 **Strategic direction** clear from research

**After Step 3 (Setup):**
- ✅ Git repository con remote configured
- ✅ CCPM system initialized per development
- ✅ Project structure ready per PRD creation

**After Step 4 (PRD Creation):**
- ✅ Comprehensive PRD con market context populated
- ✅ User journeys e acceptance criteria dettagliati
- ✅ Success metrics basati su validation findings

**After Step 5 (Planning):**
- ✅ GitHub Issues con acceptance criteria
- ✅ Task prioritizzati e stimati (1-3 giorni each)
- ✅ Epic structure per 2-4 settimane development

**After Step 6 (Development Start):**
- ✅ First task in progress con specialized agent
- ✅ Progress tracking attivo su GitHub

---

## ⚡ Alternative: Quick Experimentation Flow

**Se vuoi sperimentare rapidamente SENZA validation:**

```bash
# Quick setup (salta validation)
/pm:new-project my-experiment
/pm:prd-new experiment --from-idea IDEA.md

# Optional validation later
/pm:validate-idea IDEA.md
# → Use findings to iterate on PRD
```

**Quando usarlo:**
- ✅ Proof of concept rapidi
- ✅ Learning projects  
- ✅ Experimental features
- ❌ NON per progetti serious o business-oriented

---

## 🔄 Daily Development Workflow

```bash
# Ogni morning (30 secondi)
/context:prime              # Carica contesto progetto
/pm:standup                # Status update
/pm:next                   # Next priority task

# Durante development
/pm:issue-start <issue>    # Focus su task specifico
# ... lavora con Claude ...
/pm:issue-sync            # Sync progress to GitHub

# Fine giornata  
/pm:status                # Overall project status
```

---

## 🚨 Decision Points & Troubleshooting

### Validation NO-GO Decision

**Cosa significa:**
- 📊 Market research indica problemi serious
- ⚠️ Competitive analysis mostra market saturation  
- 📉 Scoring framework indica high-risk idea

**Cosa fare:**
1. **Leggi "Pivot Opportunities"** in VALIDATED-IDEA.md
2. **Considera alternative approaches** suggested
3. **Modifica IDEA.md** based on findings
4. **Re-run validation** con improved idea
5. **Don't proceed with setup** finché non hai GO

### Validation GO Decision

**Cosa significa:**  
- ✅ Market evidence supports the idea
- 📈 Competitive gaps identified  
- 🎯 Clear path to market entry

**Next actions:**
1. **Proceed immediately** con project setup
2. **Leverage research findings** per inform PRD
3. **Use competitive gaps** per differentiation strategy  
4. **Follow strategic recommendations** from validation

### Common Issues

**"Tasks troppo grandi":**
- ✂️ Break down manualmente in GitHub Issues
- 🎯 Target: 1-3 giorni per task max
- 📝 Use clear acceptance criteria

**"PRD non abbastanza dettagliato":**  
- 📋 PRD è product-focused, Epic è tech-focused
- 🔄 Run `/pm:prd-parse` per technical breakdown
- 💡 Epic phase ask tech stack questions

**"Git remote issues":**
- 📋 Create GitHub repository FIRST: https://github.com/new  
- 🔧 Don't initialize with README (già fatto da `/pm:new-project`)
- 🚀 Then: `git push -u origin main`

---

## 🎯 Pro Tips

1. **Validation is Worth It** - 18 min può save weeks di lavoro
2. **Respect NO-GO decisions** - AI research is data-driven  
3. **Use market context** - PRD populated da validation è superior
4. **GitHub repository first** - Create before first push
5. **Context is king** - Always `/context:prime` all'inizio sessioni
6. **Ship early, iterate** - MVP approach sempre

---

## 📚 Advanced Workflows

**Multi-PRD Projects:**
```bash  
# Main features PRD
/pm:prd-new core-features --from-idea VALIDATED-IDEA.md

# Additional PRD for future phases  
/pm:prd-new advanced-features --from-idea VALIDATED-IDEA.md
```

**Continuous Validation:**
```bash
# Re-validate during development
/pm:validate-idea REFINED-IDEA.md

# Update PRD based on new learnings
# Use findings to guide iteration decisions
```

**Cross-Platform Development:**
```bash  
# PRD definisce WHAT to build
/pm:prd-new mobile-app --from-idea VALIDATED-IDEA.md

# Epic asks HOW to build (React Native? Flutter? Native?)
/pm:prd-parse mobile-app
```

---

## 🏆 Success Metrics

**Validation Success:**
- 📊 GO/NO-GO decision con high confidence (8+/10)
- 🎯 Clear competitive differentiation identified
- 📈 Market size adequate per solo-dev (>1K users)

**Project Success:**  
- ⚡ Setup completo in <30 minuti
- 📋 GitHub Issues chiaro e actionable  
- 🚀 First feature deployed entro 1-2 settimane

**Development Success:**
- 🤖 AI-powered development con context preservation
- 📊 Regular progress updates su GitHub  
- 🎯 MVP completed seguendo validation insights

---

> **Remember:** Questo sistema è **validation-first** per **solo-developers** che vogliono **evidence-based decisions** e **rapid execution**. Trust the data, ship fast, iterate smart.

**Happy validating & coding! 🚀**