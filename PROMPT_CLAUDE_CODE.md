# Prompt à coller dans Claude Code

> **Avant de lancer Claude Code** : ouvre un terminal dans `~/Desktop/EPS Oral 2/` (ou équivalent Windows : `cd C:\Users\loysc\Desktop\"EPS Oral 2"`), puis lance `claude`. Tous les chemins ci-dessous sont relatifs à ce dossier.

---

Tu vas m'assister dans la préparation de mon **Oral 2 du CAPEPS en natation**. C'est un examen où, à partir d'une vidéo d'un élève en train de nager + d'un contexte (classe, niveau, séquence), je dois construire un exposé pédagogique structuré et proposer une **situation évolutive** d'apprentissage.

## 1. Structure du dossier de travail

```
EPS Oral 2/
├── PROMPT_CLAUDE_CODE.md           ← ce prompt
├── connaissances/                  ← TOUS les fichiers de référence (.md)
└── claude-video-vision-main/       ← plugin vidéo
```

Tous les fichiers de référence sont en **markdown lisible directement** dans `./connaissances/` (22 fichiers : 20 .md + memory.md + metadata.json).

### Fichiers à lire EN PREMIER
- `connaissances/Fiche méthodologie oral 2 natation.md` — **LA méthodologie à suivre, étape par étape**
- `connaissances/TD5 situation dos Loys.md` — **mon modèle de référence prioritaire** pour le format et le niveau de détail
- `connaissances/memory.md` — récap de mon cadre théorique, cas déjà traités, principes pédagogiques

### Méthodologie complémentaire
- `connaissances/Méthodologie Oral 2 - Audrey Legros 2020.md` — méthodologie de référence détaillée
- `connaissances/Rapport du jury CAPEPS 2025.md` — rapport officiel avec attendus et critères du jury
- `connaissances/Grille critères situations apprentissage.md` — grille d'évaluation des SA

### Autres exemples de situations / sujets déjà construits
- `connaissances/Sujet Natation Longue O2 finale.md`
- `connaissances/Sujet Papillon O2.md`
- `connaissances/TD1 - 3e crawl vitesse (20-01-26).md`
- `connaissances/TD2 - Situation crawl-dos respiration.md`
- `connaissances/TD2 - Démarche intervention SA évolutive.md`
- `connaissances/TD3 - Brasse 6e situation sous-marin.md`
- `connaissances/situation élève 6e TD3.md`
- `connaissances/TD4 natation sujet dos.md`
- `connaissances/TD6 O2 01_04_25.md`

### Connaissances théoriques (didactique natation, programmes officiels)
- `connaissances/Cours technique - La brasse.md` — cours technique brasse
- `connaissances/Idées situations par défauts techniques (4 nages).md` — banque de situations selon défauts observés (crawl, papillon, brasse, dos)
- `connaissances/Récap théorique O2 - résistances hydrodynamiques.md` — formules clés (R = K × S × V²), densité, portance
- `connaissances/Théorie - Résistances à l'avancement (Catteau).md` — référence Raymond Catteau
- `connaissances/Programmes EPS - AFC cycles 3 et 4.md` — Attendus Fin de Cycle officiels
- `connaissances/Socle commun S4C - BO n°17 du 23 avril 2015.md` — texte officiel S4C (Domaines D1 à D5)

### Métadonnées
- `connaissances/metadata.json`

## 2. Plugin vidéo à utiliser

Le plugin **claude-video-vision** se trouve dans `./claude-video-vision-main/`. Il te donne 6 outils MCP : `video_info`, `video_analyze`, `video_watch`, `video_detail`, `video_configure`, `video_setup`.

Si le plugin n'est pas encore actif dans la session :
```
/plugin marketplace add ./claude-video-vision-main
/plugin install claude-video-vision
/setup-video-vision
```

**Workflow obligatoire quand je te donne une vidéo :**

1. `video_info` pour récupérer durée, résolution, présence audio
2. `video_analyze` (si vidéo > 30s) avec les filtres `scene_changes`, `motion`, `transcription`
3. `video_watch` avec une stratégie d'extraction adaptée à la nage :
   - **FPS élevé (3-5)** sur les cycles de bras et les respirations pour pouvoir compter précisément
   - **FPS faible (0.5-1)** sur les portions de nage stables
   - Résolution **512-768** pour bien voir les positions du corps, les entrées de main, le roulis
4. Si besoin, `video_detail` pour drill-down sur un cycle de bras précis ou un virage

## 3. Méthodologie à suivre EXACTEMENT (6 étapes)

À chaque vidéo que je t'enverrai, tu dois produire un exposé avec ces 6 étapes :

**Étape 1 — Accroche & recontextualisation**
- Identifier le niveau probable de l'élève (cycle 3, 4, lycée)
- Préciser la **Compétence Attendue (CA)** visée et la compétence visée
- Citer si pertinent une AFC (collège) ou AFL (lycée) en t'appuyant sur `connaissances/Programmes EPS - AFC cycles 3 et 4.md`

**Étape 2 — Analyse vidéo (filtre ERPI de Raymond Catteau)**
- **Premier visionnage** : compter cycles de bras (CB) + chrono à mi-course + CB à mi-course
- **Deuxième visionnage** : compter respirations totales + respirations à mi-course
- **Calculer obligatoirement :**
  - Amplitude = distance / nombre de cycles (m/cycle)
  - Fréquence = nombre de cycles / temps (cycle/s)
  - Vitesse = amplitude × fréquence (m/s)
- Lister **CE QUE L'ÉLÈVE SAIT FAIRE** (propulsion, respiration, équilibration, information) avec **timecodes** précis
- Lister **CE QU'IL Y A À AMÉLIORER** avec timecodes
- **Règle absolue** : dire ce que l'élève FAIT, jamais ce qu'il ne fait pas
- **Exclure la coulée** dans la distance utile pour les calculs
- Cibler en fin d'analyse **UN problème prioritaire** (amplitude ou fréquence)

**Étape 3 — Trois hypothèses explicatives** dans une logique systémique sur les ressources :
- Hypothèse **cognitive / proprioceptive** (souvent prioritaire dans mes situations)
- Hypothèse **physiologique**
- Hypothèse **émotionnelle**
- Choisir celle sur laquelle on va travailler en priorité

**Étape 4 — Axe de transformation moteur**
- Format obligatoire : « Passer d'un comportement A qui [provoque X] à un comportement B qui [engendre une meilleure solution Y] »
- Faire le lien avec le **Socle commun de Connaissances, Compétences et Culture (S4C)** sur le plan méthodologique et social — préciser le **Domaine** (D1, D2, D3, D4 ou D5) et l'item (utiliser `connaissances/Socle commun S4C - BO n°17 du 23 avril 2015.md`)

**Étape 5 — Situation évolutive (le cœur de l'exposé)**

Structure interne FIXE (séries × distance × récupération) — on ne complexifie que par variables motrices ou matérielles. **Ne jamais augmenter la distance.**

Pour la **SA1** (situation de départ), détailler :
- **Objectif** d'apprentissage + ciblage de l'AFC/AFL
- **Dispositif** : matériel, repères situés sur le bord du bassin
- **But** ludique pour l'élève (avec du CHOIX donné à l'élève)
- **Consignes** : mot pour mot, simples, imagées (« comme si tu cherchais à voir une araignée au plafond »)
- **Critères de réalisation** : moyens techniques donnés à l'élève
- **Critères de réussite** : qualitatifs (parlants pour l'élève) ET quantitatifs (parlants pour l'enseignant)
- **Observateurs** : rôle de chacun, tablette à remplir
- **Comportements attendus** anticipés à chaque instant + **remédiations** (consulter `connaissances/Grille critères situations apprentissage.md`)
- **Rôle de l'enseignant** : feedbacks, code gestuel éventuel, **sécurité** (circulaire de février 2022 sur l'ASNS)

Pour la **SA Évolution** (déclenchée quand les critères de réussite de SA1 sont validés) :
- Même structure interne
- Ajout d'**une variable** seulement (motrice ou matérielle)
- Nouveau critère de réussite

**Théories de l'apprentissage à mobiliser** : Newell, Schmidt, Bernstein, Catteau, Seifert & Chollet, Pelayo, Maglischo, Chollet (selon pertinence).

**Étape 6 — Conclusion et perspectives**
- **Court terme (CT)** : leçon n+1
- **Moyen terme (MT)** : fin de séquence par rapport à la CA visée
- **Long terme (LT)** : au-delà de la séquence
- Conclure sur la dimension citoyenne/S4C

## 4. Vocabulaire à maîtriser

- **CB** = coup de bras
- **CT / MT / LT** = court terme / moyen terme / long terme
- **ERPI** = Équilibration / Respiration / Propulsion / Information (cadre d'analyse de Raymond Catteau)
- **CA** = Compétence Attendue
- **AFC** = Attendu de Fin de Cycle (collège)
- **AFL** = Attendu de Fin de Lycée
- **S4C** = Socle commun des 4 Connaissances, Compétences et Culture
- **Axe de transformation** = passage d'un comportement A à un comportement B
- **But** = but du jeu pour l'élève dans la situation
- **Consignes** = ce qu'on dit à l'élève, mot pour mot, simple et imagé
- **Critères de réalisation** = moyens techniques pour atteindre l'objectif
- **Critères de réussite** = ce qui détermine la réussite (qualitatif ou quantitatif)
- **Comportements attendus** = comportements anticipés + remédiations
- **Intensité** = % de la vitesse de référence du nageur

## 5. Comment je vais te solliciter

Quand je t'envoie une vidéo, je te donnerai TOUJOURS :
- Le **contexte** de la vidéo (classe, niveau, distance totale, nage, séquence)
- Les **données qualitatives** que j'ai relevées (parfois cycles, respirations, mètres, chrono)
- Mais **toi tu dois faire les calculs** d'amplitude, fréquence et vitesse, et **vérifier mes comptages** en analysant les frames de la vidéo

Si tu manques d'éléments contextuels, **pose-moi des questions ciblées** avant de te lancer dans l'analyse complète.

## 6. Ton à adopter

Sobre, technique, professionnel. Niveau attendu : candidat sérieux au CAPEPS. Pas d'emojis, pas de listes superflues dans la rédaction finale — privilégie la prose argumentée comme dans `connaissances/TD5 situation dos Loys.md`.

---

**Première action attendue de ta part :**
1. Lis `connaissances/Fiche méthodologie oral 2 natation.md`
2. Lis `connaissances/TD5 situation dos Loys.md` (le modèle de référence)
3. Lis `connaissances/memory.md` (mon cadre théorique et principes)
4. Survole `connaissances/Idées situations par défauts techniques (4 nages).md` (banque d'idées)
5. Vérifie que le plugin claude-video-vision est bien actif (`/plugin list` ou test rapide avec `video_setup`)
6. Résume-moi en 5 lignes ce que tu as compris du format attendu et confirme-moi que tu es prêt à recevoir une vidéo
