-- ============================================================
-- TRUSTLOG - Seed: Framework ISO 27001:2022
-- ============================================================
-- Executar APOS 001-schema.sql e 002-rls.sql

-- Framework
INSERT INTO frameworks (id, organization_id, slug, name, description, category, is_public, version)
VALUES (
    'b0000000-0000-0000-0000-000000000001',
    NULL,
    'iso-27001',
    'ISO/IEC 27001:2022 - Segurança da Informação',
    'Sistema de Gestão da Segurança da Informação (SGSI). Controles do Anexo A organizados por temas organizacionais, pessoas, físicos e tecnológicos.',
    'iso_27001',
    TRUE,
    '2022'
);

-- Dominios ISO 27001:2022 (Anexo A)
INSERT INTO framework_domains (id, framework_id, name, description, order_index) VALUES
('b1000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', 'Controles Organizacionais (A.5)', 'Políticas, responsabilidades, gestão de ativos, acesso, terceiros e continuidade', 1),
('b1000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'Controles de Pessoas (A.6)', 'Seleção, conscientização, responsabilidades e confidencialidade', 2),
('b1000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000001', 'Controles Físicos (A.7)', 'Perímetro, equipamentos, dispositivos e descarte seguro', 3),
('b1000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000001', 'Controles Tecnológicos (A.8)', 'Criptografia, segurança em rede, software, backup, logging e gestão de vulnerabilidades', 4);

-- Controles ISO 27001:2022
INSERT INTO controls (id, framework_id, domain_id, control_id, name, description, implementation_guidance, risk_level, control_type) VALUES

-- DOMINIO: Controles Organizacionais (A.5)
('b2000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-001',
 'Políticas de Segurança da Informação',
 'Conjunto de políticas de segurança da informação aprovado pela direção e comunicado aos colaboradores.',
 'Elaborar política de segurança. Revisar anualmente. Comunicar a todos os colaboradores e terceiros.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-002',
 'Papéis e Responsabilidades',
 'Definição e comunicação dos papéis e responsabilidades de segurança da informação.',
 'Definir CISO/DSO. Estabelecer comitê de segurança. Documentar responsabilidades em políticas.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-003',
 'Segregação de Funções',
 'Segregação de funções conflitantes para reduzir riscos.',
 'Identificar funções conflitantes. Implementar segregação. Estabelecer controles compensatórios quando inevitável.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-004',
 'Gestão de Ativos',
 'Inventário e classificação de todos os ativos de informação.',
 'Criar inventário de ativos. Classificar por criticidade. Designar proprietários. Revisar periodicamente.', 'medium', 'organizational'),

('b2000000-0000-0000-0000-000000000005', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-005',
 'Classificação da Informação',
 'Classificação da informação quanto ao nível de confidencialidade e criticidade.',
 'Definir esquema de classificação (público, interno, confidencial, restrito). Rotular informações. Controlar acesso por classificação.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000006', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-006',
 'Gestão de Riscos',
 'Processo sistemático de identificação, análise e tratamento de riscos de segurança.',
 'Estabelecer metodologia de risco. Realizar avaliação periódica. Documentar plano de tratamento.', 'critical', 'organizational'),

('b2000000-0000-0000-0000-000000000007', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-007',
 'Gestão de Riscos na Cadeia de Suprimentos',
 'Gestão de riscos de segurança relacionados a fornecedores e parceiros.',
 'Avaliar riscos de fornecedores. Incluir cláusulas de segurança em contratos. Monitorar conformidade.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000008', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-008',
 'Gestão de Continuidade de Negócios',
 'Preparação para garantir continuidade das operações em situações de crise.',
 'Criar plano de continuidade (BCP). Realizar testes periódicos. Manter plano atualizado.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000009', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-009',
 'Gestão de Mudanças',
 'Controle de mudanças em processos, sistemas e infraestrutura.',
 'Implementar processo de gestão de mudanças. Avaliar impacto na segurança. Documentar e aprovar mudanças.', 'medium', 'organizational'),

('b2000000-0000-0000-0000-000000000010', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-010',
 'Gestão de Incidentes',
 'Processo para detectar, reportar e responder a incidentes de segurança.',
 'Criar equipe de resposta (CSIRT). Estabelecer procedimento de notificação. Realizar exercícios.', 'critical', 'organizational'),

('b2000000-0000-0000-0000-000000000011', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-011',
 'Conformidade Legal e Regulatória',
 'Identificação e cumprimento de requisitos legais, regulatórios e contratuais.',
 'Manter registro de requisitos legais. Revisar conformidade periodicamente. Atualizar políticas conforme mudanças.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000012', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-012',
 'Auditorias Internas',
 'Realização periódica de auditorias internas no SGSI.',
 'Planejar ciclo de auditorias. Treinar auditores internos. Documentar achados e planos de ação.', 'medium', 'organizational'),

('b2000000-0000-0000-0000-000000000013', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 'ISO-013',
 'Gestão de Exceções e Não-Conformidades',
 'Identificação e tratamento de não-conformidades e ações corretivas.',
 'Documentar não-conformidades. Implementar ações corretivas. Verificar eficácia. Revisar pela direção.', 'medium', 'organizational'),

-- DOMINIO: Controles de Pessoas (A.6)
('b2000000-0000-0000-0000-000000000014', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'ISO-014',
 'Triagem e Seleção',
 'Verificação de antecedentes de candidatos conforme requisitos legais e de segurança.',
 'Realizar verificação de antecedentes. Verificar referências. Adequar nível de verificação ao cargo.', 'medium', 'organizational'),

('b2000000-0000-0000-0000-000000000015', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'ISO-015',
 'Acordo de Confidencialidade',
 'Acordos de confidencialidade e termos de responsabilidade para colaboradores e terceiros.',
 'Exigir termo de confidencialidade na admissão. Revisar periodicamente. Aplicar a prestadores de serviço.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000016', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'ISO-016',
 'Conscientização e Treinamento',
 'Programa de conscientação e treinamento em segurança da informação.',
 'Realizar treinamento inicial e periódico. Abordar phishing, engenharia social e políticas internas. Medir eficácia.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000017', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'ISO-017',
 'Processo Disciplinar',
 'Processo disciplinar formal para violações de segurança da informação.',
 'Estabelecer código de conduta. Definir consequências para violações. Comunicar processo a todos.', 'medium', 'organizational'),

('b2000000-0000-0000-0000-000000000018', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000002', 'ISO-018',
 'Desligamento',
 'Procedimentos para revogação de acessos e devolução de ativos no desligamento.',
 'Criar checklist de desligamento. Revogar acessos imediatamente. Coletar ativos da empresa.', 'high', 'organizational'),

-- DOMINIO: Controles Físicos (A.7)
('b2000000-0000-0000-0000-000000000019', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'ISO-019',
 'Perímetro de Segurança Física',
 'Definição e proteção do perímetro físico das áreas seguras.',
 'Implementar controle de acesso físico. Utilizar crachás ou biometria. Monitorar entradas e saídas.', 'medium', 'physical'),

('b2000000-0000-0000-0000-000000000020', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'ISO-020',
 'Controle de Acesso Físico',
 'Garantia de que apenas pessoas autorizadas acessam áreas com informações sensíveis.',
 'Implementar catracas/portas com trava. Manter registro de visitantes. Revisar acessos trimestralmente.', 'high', 'physical'),

('b2000000-0000-0000-0000-000000000021', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'ISO-021',
 'Segurança de Equipamentos',
 'Proteção de equipamentos contra ameaças físicas e ambientais.',
 'Posicionar equipamentos em locais seguros. Proteger contra incêndio e inundação. Usar nobreak/gerador.', 'medium', 'physical'),

('b2000000-0000-0000-0000-000000000022', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'ISO-022',
 'Descarte e Reúso Seguro',
 'Descarte ou reúso seguro de equipamentos e mídias.',
 'Implementar procedimento de sanitização. Destruir fisicamente mídias com dados sensíveis. Certificar descarte.', 'high', 'physical'),

('b2000000-0000-0000-0000-000000000023', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000003', 'ISO-023',
 'Política de Mesa Limpa e Tela Limpa',
 'Exigência de ambiente de trabalho livre de documentos e telas desbloqueadas.',
 'Estabelecer política de mesa limpa. Travar estação de trabalho ao ausentar-se. Guardar documentos confidenciais.', 'low', 'physical'),

-- DOMINIO: Controles Tecnológicos (A.8)
('b2000000-0000-0000-0000-000000000024', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-024',
 'Controle de Acesso Lógico',
 'Política e implementação de controle de acesso a sistemas e dados.',
 'Implementar RBAC. Aplicar menor privilégio. Revisar acessos periodicamente. Remover acessos desnecessários.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000025', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-025',
 'Gerenciamento de Identidades e Acessos',
 'Gestão do ciclo de vida de identidades de usuários.',
 'Processo de provisioning e deprovisioning. Autenticação multifator (MFA). Revisão periódica de acessos.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000026', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-026',
 'Autenticação Multifator (MFA)',
 'Implementação de MFA para acesso a sistemas críticos.',
 'Implementar MFA em todos os acessos remotos. Priorizar sistemas críticos. Utilizar aplicativo autenticador ou chave física.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000027', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-027',
 'Gestão de Senhas',
 'Política e mecanismos para criação e gerenciamento seguro de senhas.',
 'Exigir senhas fortes. Implementar bloqueio após tentativas. Utilizar cofre de senhas corporativo.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000028', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-028',
 'Criptografia',
 'Utilização de criptografia para proteção de informações sensíveis.',
 'Criptografar dados em repouso (disco/database). Criptografar dados em trânsito (TLS). Gerenciar chaves com segurança.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000029', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-029',
 'Segurança em Redes',
 'Segmentação e proteção das redes de computadores.',
 'Segmentar redes (DMZ, interna, guest). Utilizar firewalls. Monitorar tráfego de rede.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000030', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-030',
 'Backup e Recuperação',
 'Realização periódica de backups e testes de recuperação.',
 'Definir política de backup (frequência, retenção). Realizar backups offsite. Testar recuperação periodicamente.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000031', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-031',
 'Proteção contra Malware',
 'Implementação de proteção contra códigos maliciosos.',
 'Instalar antivírus/EDR em endpoints. Manter assinaturas atualizadas. Bloquear anexos suspeitos em email.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000032', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-032',
 'Gestão de Vulnerabilidades Técnicas',
 'Identificação e remediação de vulnerabilidades em sistemas.',
 'Realizar varreduras periódicas. Priorizar por severidade. Estabelecer SLA de remediação.', 'critical', 'technical'),

('b2000000-0000-0000-0000-000000000033', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-033',
 'Log e Monitoramento',
 'Registro e monitoramento de eventos de segurança.',
 'Centralizar logs (SIEM). Monitorar eventos críticos. Proteger integridade dos logs. Definir retenção.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000034', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-034',
 'Segurança em Desenvolvimento',
 'Integração de segurança no ciclo de desenvolvimento de software.',
 'Implementar Secure SDLC. Realizar revisão de código. Testar segurança antes de deploy.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000035', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-035',
 'Testes de Penetração',
 'Realização periódica de testes de penetração.',
 'Contratar testes externos anualmente. Escopar criticidade dos sistemas. Remediar achados críticos.', 'high', 'technical'),

('b2000000-0000-0000-0000-000000000036', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-036',
 'Gestão de Dispositivos Móveis',
 'Política e controles para uso de dispositivos móveis.',
 'Exigir criptografia em dispositivos móveis. Implementar MDM. Permitir wipe remoto.', 'medium', 'technical'),

('b2000000-0000-0000-0000-000000000037', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-037',
 'Trabalho Remoto',
 'Política e controles para trabalho remoto seguro.',
 'Exigir VPN para acesso remoto. Implementar MFA. Estabelecer política de uso aceitável para home office.', 'high', 'organizational'),

('b2000000-0000-0000-0000-000000000038', 'b0000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000004', 'ISO-038',
 'Segurança em Cloud',
 'Controles específicos para uso de serviços em nuvem.',
 'Avaliar provedor cloud. Configurar controles de acesso adequados. Criptografar dados. Monitorar configurações.', 'high', 'technical');
