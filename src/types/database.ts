export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[];

export type Role = "admin" | "compliance_manager" | "auditor" | "member";
export type FrameworkCategory = "lgpd" | "iso_27001" | "soc_2" | "custom";
export type RiskLevel = "low" | "medium" | "high" | "critical";
export type ControlType = "technical" | "organizational" | "physical";
export type ControlComplianceStatus = "compliant" | "non_compliant" | "not_assessed" | "in_progress" | "not_applicable";
export type EvidenceType = "file" | "text" | "integration" | "attestation";
export type EvidenceStatus = "pending" | "approved" | "rejected" | "expired";
export type PolicyStatus = "draft" | "published" | "archived";
export type RiskStatus = "identified" | "analyzing" | "treating" | "monitoring" | "closed";
export type RiskCategory = "strategic" | "operational" | "financial" | "legal" | "reputational";
export type RiskTreatment = "accept" | "mitigate" | "transfer" | "avoid";
export type AssessmentStatus = "draft" | "in_progress" | "completed" | "archived";
export type AuditStatus = "planned" | "in_progress" | "completed" | "cancelled";
export type FindingStatus = "open" | "in_progress" | "resolved" | "accepted";
export type FindingSeverity = "critical" | "high" | "medium" | "low" | "informational";
export type MappingType = "equivalent" | "subset" | "superset" | "related";

export interface Database {
  public: {
    Tables: {
      organizations: {
        Row: Organization;
        Insert: OrganizationInsert;
        Update: OrganizationUpdate;
      };
      profiles: {
        Row: Profile;
        Insert: ProfileInsert;
        Update: ProfileUpdate;
      };
      frameworks: {
        Row: Framework;
        Insert: FrameworkInsert;
        Update: FrameworkUpdate;
      };
      framework_domains: {
        Row: FrameworkDomain;
        Insert: FrameworkDomainInsert;
        Update: FrameworkDomainUpdate;
      };
      controls: {
        Row: Control;
        Insert: ControlInsert;
        Update: ControlUpdate;
      };
      control_mappings: {
        Row: ControlMapping;
        Insert: ControlMappingInsert;
        Update: ControlMappingUpdate;
      };
      policies: {
        Row: Policy;
        Insert: PolicyInsert;
        Update: PolicyUpdate;
      };
      policy_controls: {
        Row: PolicyControl;
        Insert: PolicyControlInsert;
        Update: PolicyControlUpdate;
      };
      evidence: {
        Row: Evidence;
        Insert: EvidenceInsert;
        Update: EvidenceUpdate;
      };
      control_status: {
        Row: ControlStatus;
        Insert: ControlStatusInsert;
        Update: ControlStatusUpdate;
      };
      risk_assessments: {
        Row: RiskAssessment;
        Insert: RiskAssessmentInsert;
        Update: RiskAssessmentUpdate;
      };
      risks: {
        Row: Risk;
        Insert: RiskInsert;
        Update: RiskUpdate;
      };
      audits: {
        Row: Audit;
        Insert: AuditInsert;
        Update: AuditUpdate;
      };
      audit_findings: {
        Row: AuditFinding;
        Insert: AuditFindingInsert;
        Update: AuditFindingUpdate;
      };
      organization_invites: {
        Row: OrganizationInvite;
        Insert: OrganizationInviteInsert;
        Update: OrganizationInviteUpdate;
      };
    };
    Views: Record<string, never>;
    Functions: {
      get_user_org_id: {
        Args: Record<string, never>;
        Returns: string;
      };
      has_role: {
        Args: { required_roles: string[] };
        Returns: boolean;
      };
    };
    Enums: Record<string, never>;
  };
}

// --- Row types (what comes from DB) ---

export interface Organization {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  created_at: string;
  updated_at: string;
}

export interface Profile {
  id: string;
  organization_id: string;
  email: string;
  name: string | null;
  avatar_url: string | null;
  role: Role;
  created_at: string;
  updated_at: string;
}

export interface Framework {
  id: string;
  organization_id: string | null;
  slug: string;
  name: string;
  description: string | null;
  category: FrameworkCategory;
  is_public: boolean;
  version: string;
  created_at: string;
  updated_at: string;
}

export interface FrameworkDomain {
  id: string;
  framework_id: string;
  name: string;
  description: string | null;
  order_index: number;
  created_at: string;
}

export interface Control {
  id: string;
  framework_id: string;
  domain_id: string | null;
  control_id: string;
  name: string;
  description: string | null;
  implementation_guidance: string | null;
  risk_level: RiskLevel | null;
  control_type: ControlType | null;
  created_at: string;
  updated_at: string;
}

export interface ControlMapping {
  id: string;
  source_control_id: string;
  target_control_id: string;
  mapping_type: MappingType | null;
  notes: string | null;
  created_at: string;
}

export interface Policy {
  id: string;
  organization_id: string;
  title: string;
  content: string | null;
  version: number;
  status: PolicyStatus;
  created_by: string | null;
  published_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface PolicyControl {
  id: string;
  policy_id: string;
  control_id: string;
  created_at: string;
}

export interface Evidence {
  id: string;
  organization_id: string;
  control_id: string;
  title: string;
  description: string | null;
  type: EvidenceType;
  file_url: string | null;
  file_type: string | null;
  file_size: number | null;
  collected_by: string | null;
  collected_at: string;
  expires_at: string | null;
  status: EvidenceStatus;
  reviewed_by: string | null;
  reviewed_at: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface ControlStatus {
  id: string;
  organization_id: string;
  control_id: string;
  status: ControlComplianceStatus;
  updated_by: string | null;
  notes: string | null;
  updated_at: string;
}

export interface RiskAssessment {
  id: string;
  organization_id: string;
  title: string;
  description: string | null;
  methodology: string | null;
  status: AssessmentStatus;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface Risk {
  id: string;
  organization_id: string;
  assessment_id: string | null;
  title: string;
  description: string | null;
  category: RiskCategory | null;
  likelihood: number;
  impact: number;
  risk_score: number;
  status: RiskStatus;
  treatment: RiskTreatment | null;
  treatment_details: string | null;
  owner_id: string | null;
  created_at: string;
  updated_at: string;
}

export interface Audit {
  id: string;
  organization_id: string;
  framework_id: string;
  title: string;
  status: AuditStatus;
  start_date: string | null;
  end_date: string | null;
  auditor_name: string | null;
  auditor_company: string | null;
  notes: string | null;
  created_by: string | null;
  created_at: string;
  updated_at: string;
}

export interface AuditFinding {
  id: string;
  audit_id: string;
  control_id: string | null;
  status: FindingStatus;
  severity: FindingSeverity;
  title: string;
  description: string | null;
  remediation_plan: string | null;
  due_date: string | null;
  assigned_to: string | null;
  created_at: string;
  updated_at: string;
}

export interface OrganizationInvite {
  id: string;
  organization_id: string;
  email: string;
  role: Role;
  invited_by: string | null;
  token: string;
  expires_at: string;
  accepted_at: string | null;
  created_at: string;
}

// --- Insert types ---

export interface OrganizationInsert {
  name: string;
  slug: string;
  logo_url?: string | null;
}

export interface ProfileInsert {
  id: string;
  organization_id: string;
  email: string;
  name?: string | null;
  avatar_url?: string | null;
  role: Role;
}

export interface FrameworkInsert {
  organization_id?: string | null;
  slug: string;
  name: string;
  description?: string | null;
  category: FrameworkCategory;
  is_public?: boolean;
  version?: string;
}

export interface FrameworkDomainInsert {
  framework_id: string;
  name: string;
  description?: string | null;
  order_index?: number;
}

export interface ControlInsert {
  framework_id: string;
  domain_id?: string | null;
  control_id: string;
  name: string;
  description?: string | null;
  implementation_guidance?: string | null;
  risk_level?: RiskLevel | null;
  control_type?: ControlType | null;
}

export interface ControlMappingInsert {
  source_control_id: string;
  target_control_id: string;
  mapping_type?: MappingType | null;
  notes?: string | null;
}

export interface PolicyInsert {
  organization_id: string;
  title: string;
  content?: string | null;
  version?: number;
  status?: PolicyStatus;
  created_by?: string | null;
}

export interface PolicyControlInsert {
  policy_id: string;
  control_id: string;
}

export interface EvidenceInsert {
  organization_id: string;
  control_id: string;
  title: string;
  description?: string | null;
  type: EvidenceType;
  file_url?: string | null;
  file_type?: string | null;
  file_size?: number | null;
  collected_by?: string | null;
  collected_at?: string;
  expires_at?: string | null;
  status?: EvidenceStatus;
  reviewed_by?: string | null;
  notes?: string | null;
}

export interface ControlStatusInsert {
  organization_id: string;
  control_id: string;
  status?: ControlComplianceStatus;
  updated_by?: string | null;
  notes?: string | null;
}

export interface RiskAssessmentInsert {
  organization_id: string;
  title: string;
  description?: string | null;
  methodology?: string | null;
  status?: AssessmentStatus;
  created_by?: string | null;
}

export interface RiskInsert {
  organization_id: string;
  assessment_id?: string | null;
  title: string;
  description?: string | null;
  category?: RiskCategory | null;
  likelihood: number;
  impact: number;
  status?: RiskStatus;
  treatment?: RiskTreatment | null;
  treatment_details?: string | null;
  owner_id?: string | null;
}

export interface AuditInsert {
  organization_id: string;
  framework_id: string;
  title: string;
  status?: AuditStatus;
  start_date?: string | null;
  end_date?: string | null;
  auditor_name?: string | null;
  auditor_company?: string | null;
  notes?: string | null;
  created_by?: string | null;
}

export interface AuditFindingInsert {
  audit_id: string;
  control_id?: string | null;
  status: FindingStatus;
  severity: FindingSeverity;
  title: string;
  description?: string | null;
  remediation_plan?: string | null;
  due_date?: string | null;
  assigned_to?: string | null;
}

export interface OrganizationInviteInsert {
  organization_id: string;
  email: string;
  role?: Role;
  invited_by?: string | null;
  expires_at: string;
}

// --- Update types (all optional) ---

export interface OrganizationUpdate {
  name?: string;
  slug?: string;
  logo_url?: string | null;
}

export interface ProfileUpdate {
  organization_id?: string;
  email?: string;
  name?: string | null;
  avatar_url?: string | null;
  role?: Role;
}

export interface FrameworkUpdate {
  organization_id?: string | null;
  slug?: string;
  name?: string;
  description?: string | null;
  category?: FrameworkCategory;
  is_public?: boolean;
  version?: string;
}

export interface FrameworkDomainUpdate {
  framework_id?: string;
  name?: string;
  description?: string | null;
  order_index?: number;
}

export interface ControlUpdate {
  framework_id?: string;
  domain_id?: string | null;
  control_id?: string;
  name?: string;
  description?: string | null;
  implementation_guidance?: string | null;
  risk_level?: RiskLevel | null;
  control_type?: ControlType | null;
}

export interface ControlMappingUpdate {
  source_control_id?: string;
  target_control_id?: string;
  mapping_type?: MappingType | null;
  notes?: string | null;
}

export interface PolicyUpdate {
  organization_id?: string;
  title?: string;
  content?: string | null;
  version?: number;
  status?: PolicyStatus;
  created_by?: string | null;
}

export interface PolicyControlUpdate {
  policy_id?: string;
  control_id?: string;
}

export interface EvidenceUpdate {
  organization_id?: string;
  control_id?: string;
  title?: string;
  description?: string | null;
  type?: EvidenceType;
  file_url?: string | null;
  file_type?: string | null;
  file_size?: number | null;
  collected_by?: string | null;
  collected_at?: string;
  expires_at?: string | null;
  status?: EvidenceStatus;
  reviewed_by?: string | null;
  notes?: string | null;
}

export interface ControlStatusUpdate {
  organization_id?: string;
  control_id?: string;
  status?: ControlComplianceStatus;
  updated_by?: string | null;
  notes?: string | null;
}

export interface RiskAssessmentUpdate {
  organization_id?: string;
  title?: string;
  description?: string | null;
  methodology?: string | null;
  status?: AssessmentStatus;
  created_by?: string | null;
}

export interface RiskUpdate {
  organization_id?: string;
  assessment_id?: string | null;
  title?: string;
  description?: string | null;
  category?: RiskCategory | null;
  likelihood?: number;
  impact?: number;
  status?: RiskStatus;
  treatment?: RiskTreatment | null;
  treatment_details?: string | null;
  owner_id?: string | null;
}

export interface AuditUpdate {
  organization_id?: string;
  framework_id?: string;
  title?: string;
  status?: AuditStatus;
  start_date?: string | null;
  end_date?: string | null;
  auditor_name?: string | null;
  auditor_company?: string | null;
  notes?: string | null;
  created_by?: string | null;
}

export interface AuditFindingUpdate {
  audit_id?: string;
  control_id?: string | null;
  status?: FindingStatus;
  severity?: FindingSeverity;
  title?: string;
  description?: string | null;
  remediation_plan?: string | null;
  due_date?: string | null;
  assigned_to?: string | null;
}

export interface OrganizationInviteUpdate {
  organization_id?: string;
  email?: string;
  role?: Role;
  invited_by?: string | null;
  token?: string;
  expires_at?: string;
  accepted_at?: string | null;
}
