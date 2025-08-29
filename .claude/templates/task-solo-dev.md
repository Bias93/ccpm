---
name: [Task Name - Professional & Cost-Effective]
status: open
created: [CURRENT_ISO_DATE]
updated: [CURRENT_ISO_DATE]
github: [Will be updated when synced to GitHub]
depends_on: []  # List of task numbers this depends on, e.g., [001, 002]
parallel: true  # Can this run in parallel with other tasks?
conflicts_with: []  # Tasks that modify same files, e.g., [003, 004]
subagent_type: [project-setup-specialist|project-backend-specialist|project-frontend-specialist|project-data-specialist|project-testing-specialist|project-deployment-specialist|project-integration-specialist]  # Which project-specific agent should handle this
subagent_context: |  # Optional: specific context for this task
  [Additional context or requirements specific to this task]
  
  Project Stack: [Automatically populated from agent-generate command]
  Key Requirements: [Relevant requirements from PRD]
  Implementation Notes: [Any specific guidance for this task]
---

# Task: [Task Name]

## Description
Clear, concise description focusing on deliverable value for solo developers.

## Acceptance Criteria
- [ ] Specific, testable criterion with business value
- [ ] Technical implementation meets professional standards
- [ ] Cost-effective solution chosen over premium alternatives
- [ ] Performance meets Core Web Vitals standards
- [ ] Mobile-responsive and accessible (WCAG 2.1 AA)

## Technical Details (2025 Stack)

### Implementation Approach
- **Framework**: Next.js 15.5+ (App Router, Server Actions)
- **Language**: TypeScript 5.7+ (strict mode)
- **Styling**: Tailwind CSS 3.4+ (no license fees)
- **Components**: shadcn/ui (free, customizable, accessible)
- **Icons**: Lucide React (tree-shakeable, comprehensive)

### Cost-Effective Choices
- **Hosting**: Vercel/Netlify (free tier sufficient)
- **Database**: PostgreSQL with Prisma ORM (type-safe)
- **Authentication**: NextAuth.js v5 (free, comprehensive)
- **Storage**: Vercel Blob or Supabase Storage
- **Analytics**: Vercel Analytics (free tier)

### Solo-Dev Optimizations
- Leverage built-in Next.js optimizations
- Minimize external API calls
- Use server components for performance
- Implement progressive enhancement
- Choose managed services over self-hosted

## Dependencies
- [ ] Task/Issue dependencies (specify by number)
- [ ] External service setup (if any)
- [ ] Environment configuration

## Effort Estimate
- **Size**: XS/S/M/L/XL (1-2 days max for solo efficiency)
- **Hours**: [realistic estimate] 
- **Parallel**: true/false (based on file conflicts)
- **Cost Impact**: $[monthly cost if any recurring fees]

## Performance Requirements
- [ ] Core Web Vitals: LCP < 2.5s, FID < 100ms, CLS < 0.1
- [ ] Mobile PageSpeed score > 90
- [ ] Accessibility score > 95
- [ ] SEO optimization implemented

## Definition of Done
- [ ] Code implemented following professional standards
- [ ] Unit tests written (Vitest) for business logic
- [ ] Integration tests for API endpoints (if applicable)
- [ ] E2E test for critical user path (Playwright)
- [ ] Code reviewed (self-review checklist completed)
- [ ] Performance optimized and measured
- [ ] Accessibility verified (axe-core)
- [ ] Mobile responsiveness tested
- [ ] Documentation updated (if applicable)
- [ ] Deployed to staging and verified
- [ ] Production deployment ready

## Solo-Dev Checklist
- [ ] Solution uses free/open-source tools where possible
- [ ] No unnecessary complexity or over-engineering
- [ ] Follows established patterns in codebase
- [ ] Maintains professional quality standards
- [ ] Cost impact documented and justified
- [ ] Can be maintained by single developer
- [ ] Performance impact measured and acceptable
- [ ] Security considerations addressed

## Professional Standards
- [ ] Code follows TypeScript strict mode
- [ ] Error handling implemented with user-friendly messages
- [ ] Loading states and optimistic updates where appropriate
- [ ] Consistent with design system (shadcn/ui)
- [ ] SEO metadata included (if user-facing)
- [ ] Analytics events implemented (if applicable)

## Notes
Additional context, links, or considerations specific to this task.

---

**Template Usage Instructions:**

1. **Replace placeholders** with actual values:
   - `[Task Name]` → Descriptive task name
   - `[CURRENT_ISO_DATE]` → Output from `date -u +"%Y-%m-%dT%H:%M:%SZ"`
   - Effort estimates, dependencies, etc.

2. **Customize sections** based on task type:
   - Backend tasks: Focus on API design, database, serverless
   - Frontend tasks: Emphasize UI/UX, performance, accessibility  
   - Testing tasks: Specify test types and coverage requirements

3. **Cost considerations**:
   - Always evaluate free tier options first
   - Document any recurring costs
   - Justify premium tools only when necessary

4. **Solo-dev principles**:
   - Prefer simple, proven solutions
   - Minimize maintenance burden
   - Focus on essential features first
   - Leverage platform optimizations (Next.js, Vercel)

**Example Cost-Effective Tech Choices:**

| Category | Premium Option | Solo-Dev Choice | Savings |
|----------|----------------|-----------------|---------|
| UI Library | Material-UI Pro | shadcn/ui | $15/month |
| Icons | Heroicons Pro | Lucide React | $9/month |
| Forms | Formik + Yup | React Hook Form + Zod | Free |
| Hosting | AWS/Azure | Vercel/Netlify | $20-50/month |
| Database | RDS | PlanetScale/Supabase | $25-100/month |
| Auth | Auth0 | NextAuth.js | $25/month |

**Professional Quality Maintained:**
- TypeScript for type safety
- Comprehensive testing strategy
- Accessibility compliance
- Performance optimization
- Security best practices
- SEO optimization
- Mobile-first responsive design