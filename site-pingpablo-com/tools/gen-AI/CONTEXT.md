# CONTEXT

## Usage Instructions

When referencing this context:
1. Always read the **General Statement** first
2. Then consult the specific **Topic** relevant to your task
3. Align all work with the three core principles: Simplicity, Compatibility, Automation

## General Statement

This is a personal technical blog built with Hugo, a static site generator. The project embodies three core principles:

**Simplicity** - Static site architecture, minimal dependencies, straightforward tooling. Content written in Markdown, deployed via GitHub Actions, hosted as static files.

**Compatibility** - Standards-based approach using Hugo framework, semantic HTML, portable Markdown format. Works across platforms and browsers without complex runtime requirements.

**Automation** - CI/CD pipeline for builds and deployments, validation scripts for content consistency (category checking, image metadata), Makefile for reproducible local workflows.

**Open-source and collaboration** - Advocate for this

### Project Purpose

Share technical knowledge about IT, Linux, InfoSec, Networking, and Cloud Computing. Document personal projects, tools, and learning experiences. Create a space for technical content that is useful and enjoyable for both the author and readers.

### Content Philosophy

- Technical focus only - no personal or emotional topics
- Quality over quantity - infrequent but meaningful posts
- Practical orientation - document real projects and daily tools
- Share perspective - explain not just "what" but "how" and "why"
- Community value - content should be useful to others

### Technical Stack

- **Framework**: Hugo (static site generator)
- **Theme**: hugo-theme-hello-friend-xt (customized)
- **Deployment**: GitHub Actions → automated builds
- **Hosting**: Static file hosting (details abstracted in CI/CD)
- **Comments**: Giscus (GitHub-based commenting system)
- **Content**: Markdown with frontmatter metadata

### Automation & Quality

- Pre-build validation (category checking via `check-categories.sh`)
- Image metadata standardization (`update-image-metadata.sh`)
- Makefile-driven build process with prechecks
- Separate dev/main branch deployments

---

## Topic Index

### 1. Keeping a Changelog

**File Location**: `/CHANGELOG.md` (repository root)

**Version Format**: `YYYY.MM.DD.HH.MM`

**Workflow**:
1. User requests changelog update
2. Check git history for changes (user may specify date range)
3. Generate entry summarizing meaningful changes
4. Add new entry to CHANGELOG.md

**Purpose**: Informal track record of meaningful changes, not formal software releases

**When generating entries**:
- Review git commits since last entry or specified date
- Summarize changes in clear, concise language
- Focus on meaningful updates (features, fixes, content additions)
- Skip trivial commits (typos, formatting-only changes)
- Use present tense, imperative mood ("Add feature" not "Added feature")
- Group related changes together
- Order is chronological, with newer entries at top.

