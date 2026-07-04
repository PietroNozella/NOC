-- ============================================================
-- TRUSTLOG - Row Level Security (RLS)
-- ============================================================
-- Executar APOS o 001-schema.sql

-- Habilita RLS em todas as tabelas
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE frameworks ENABLE ROW LEVEL SECURITY;
ALTER TABLE framework_domains ENABLE ROW LEVEL SECURITY;
ALTER TABLE controls ENABLE ROW LEVEL SECURITY;
ALTER TABLE control_mappings ENABLE ROW LEVEL SECURITY;
ALTER TABLE policies ENABLE ROW LEVEL SECURITY;
ALTER TABLE policy_controls ENABLE ROW LEVEL SECURITY;
ALTER TABLE evidence ENABLE ROW LEVEL SECURITY;
ALTER TABLE control_status ENABLE ROW LEVEL SECURITY;
ALTER TABLE risk_assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE risks ENABLE ROW LEVEL SECURITY;
ALTER TABLE audits ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_findings ENABLE ROW LEVEL SECURITY;
ALTER TABLE organization_invites ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- FUNCAO AUXILIAR: retorna organization_id do usuario logado
-- ============================================================
CREATE OR REPLACE FUNCTION get_user_org_id()
RETURNS UUID
LANGUAGE SQL STABLE SECURITY DEFINER
AS $$
    SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$;

-- ============================================================
-- FUNCAO AUXILIAR: verifica se usuario tem papel na org
-- ============================================================
CREATE OR REPLACE FUNCTION has_role(required_roles TEXT[])
RETURNS BOOLEAN
LANGUAGE SQL STABLE SECURITY DEFINER
AS $$
    SELECT role = ANY(required_roles)
    FROM public.profiles
    WHERE id = auth.uid() AND organization_id = get_user_org_id();
$$;

-- ============================================================
-- ORGANIZATIONS
-- ============================================================
CREATE POLICY "Membros veem sua propria organizacao"
    ON organizations FOR SELECT
    USING (id = get_user_org_id());

CREATE POLICY "Admins podem atualizar a organizacao"
    ON organizations FOR UPDATE
    USING (id = get_user_org_id() AND has_role(ARRAY['admin']));

-- ============================================================
-- PROFILES
-- ============================================================
CREATE POLICY "Membros veem perfis da propria org"
    ON profiles FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Usuario pode atualizar seu proprio perfil"
    ON profiles FOR UPDATE
    USING (id = auth.uid());

-- ============================================================
-- FRAMEWORKS
-- ============================================================
CREATE POLICY "Membros veem frameworks da org e publicos"
    ON frameworks FOR SELECT
    USING (
        organization_id = get_user_org_id()
        OR organization_id IS NULL
        OR is_public = true
    );

CREATE POLICY "Admins e compliance managers gerenciam frameworks"
    ON frameworks FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins e compliance managers atualizam frameworks"
    ON frameworks FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins e compliance managers deletam frameworks"
    ON frameworks FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

-- ============================================================
-- FRAMEWORK_DOMAINS
-- ============================================================
CREATE POLICY "Membros veem dominios dos frameworks acessiveis"
    ON framework_domains FOR SELECT
    USING (
        framework_id IN (
            SELECT id FROM frameworks
            WHERE organization_id = get_user_org_id()
            OR organization_id IS NULL
            OR is_public = true
        )
    );

CREATE POLICY "Admins e compliance managers gerenciam dominios"
    ON framework_domains FOR INSERT
    WITH CHECK (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers atualizam dominios"
    ON framework_domains FOR UPDATE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers deletam dominios"
    ON framework_domains FOR DELETE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

-- ============================================================
-- CONTROLS
-- ============================================================
CREATE POLICY "Membros veem controles dos frameworks acessiveis"
    ON controls FOR SELECT
    USING (
        framework_id IN (
            SELECT id FROM frameworks
            WHERE organization_id = get_user_org_id()
            OR organization_id IS NULL
            OR is_public = true
        )
    );

CREATE POLICY "Admins e compliance managers gerenciam controles"
    ON controls FOR INSERT
    WITH CHECK (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers atualizam controles"
    ON controls FOR UPDATE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers deletam controles"
    ON controls FOR DELETE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

-- ============================================================
-- CONTROL_MAPPINGS
-- ============================================================
CREATE POLICY "Membros veem mapeamentos"
    ON control_mappings FOR SELECT
    USING (true);

CREATE POLICY "Admins e compliance managers gerenciam mapeamentos"
    ON control_mappings FOR INSERT
    WITH CHECK (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers atualizam mapeamentos"
    ON control_mappings FOR UPDATE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers deletam mapeamentos"
    ON control_mappings FOR DELETE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

-- ============================================================
-- POLICIES
-- ============================================================
CREATE POLICY "Membros veem politicas da org"
    ON policies FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Admins e compliance managers criam politicas"
    ON policies FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Criador e admins atualizam politicas"
    ON policies FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND (created_by = auth.uid() OR has_role(ARRAY['admin']))
    );

CREATE POLICY "Admins deletam politicas"
    ON policies FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );

-- ============================================================
-- POLICY_CONTROLS
-- ============================================================
CREATE POLICY "Membros veem vinculos"
    ON policy_controls FOR SELECT
    USING (
        policy_id IN (
            SELECT id FROM policies WHERE organization_id = get_user_org_id()
        )
    );

CREATE POLICY "Admins e compliance managers gerenciam vinculos"
    ON policy_controls FOR INSERT
    WITH CHECK (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers deletam vinculos"
    ON policy_controls FOR DELETE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

-- ============================================================
-- EVIDENCE
-- ============================================================
CREATE POLICY "Membros veem evidencias da org"
    ON evidence FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Membros podem adicionar evidencias"
    ON evidence FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND collected_by = auth.uid()
    );

CREATE POLICY "Criador e compliance managers atualizam evidencias"
    ON evidence FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND (collected_by = auth.uid() OR has_role(ARRAY['admin', 'compliance_manager']))
    );

CREATE POLICY "Admins e compliance managers deletam evidencias"
    ON evidence FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

-- ============================================================
-- CONTROL_STATUS
-- ============================================================
CREATE POLICY "Membros veem status dos controles"
    ON control_status FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Membros podem atualizar status"
    ON control_status FOR INSERT
    WITH CHECK (organization_id = get_user_org_id());

CREATE POLICY "Membros podem atualizar status existente"
    ON control_status FOR UPDATE
    USING (organization_id = get_user_org_id());

-- ============================================================
-- RISK_ASSESSMENTS
-- ============================================================
CREATE POLICY "Membros veem avaliacoes de risco"
    ON risk_assessments FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Admins e compliance managers gerenciam avaliacoes"
    ON risk_assessments FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins e compliance managers atualizam avaliacoes"
    ON risk_assessments FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins deletam avaliacoes"
    ON risk_assessments FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );

-- ============================================================
-- RISKS
-- ============================================================
CREATE POLICY "Membros veem riscos da org"
    ON risks FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Membros podem reportar riscos"
    ON risks FOR INSERT
    WITH CHECK (organization_id = get_user_org_id());

CREATE POLICY "Owner e admins atualizam riscos"
    ON risks FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND (owner_id = auth.uid() OR has_role(ARRAY['admin', 'compliance_manager']))
    );

CREATE POLICY "Admins deletam riscos"
    ON risks FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );

-- ============================================================
-- AUDITS
-- ============================================================
CREATE POLICY "Membros veem auditorias"
    ON audits FOR SELECT
    USING (organization_id = get_user_org_id());

CREATE POLICY "Admins e compliance managers gerenciam auditorias"
    ON audits FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins e compliance managers atualizam auditorias"
    ON audits FOR UPDATE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins deletam auditorias"
    ON audits FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );

-- ============================================================
-- AUDIT_FINDINGS
-- ============================================================
CREATE POLICY "Membros veem achados"
    ON audit_findings FOR SELECT
    USING (
        audit_id IN (
            SELECT id FROM audits WHERE organization_id = get_user_org_id()
        )
    );

CREATE POLICY "Admins e compliance managers gerenciam achados"
    ON audit_findings FOR INSERT
    WITH CHECK (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins e compliance managers atualizam achados"
    ON audit_findings FOR UPDATE
    USING (has_role(ARRAY['admin', 'compliance_manager']));

CREATE POLICY "Admins deletam achados"
    ON audit_findings FOR DELETE
    USING (has_role(ARRAY['admin']));

-- ============================================================
-- ORGANIZATION_INVITES
-- ============================================================
CREATE POLICY "Admins e compliance managers veem convites"
    ON organization_invites FOR SELECT
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin', 'compliance_manager'])
    );

CREATE POLICY "Admins convidam"
    ON organization_invites FOR INSERT
    WITH CHECK (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );

CREATE POLICY "Admins deletam convites"
    ON organization_invites FOR DELETE
    USING (
        organization_id = get_user_org_id()
        AND has_role(ARRAY['admin'])
    );
