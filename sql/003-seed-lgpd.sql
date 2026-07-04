-- ============================================================
-- TRUSTLOG - Seed: Framework LGPD
-- ============================================================
-- Executar APOS 001-schema.sql e 002-rls.sql

-- Framework
INSERT INTO frameworks (id, organization_id, slug, name, description, category, is_public, version)
VALUES (
    'a0000000-0000-0000-0000-000000000001',
    NULL,
    'lgpd',
    'Lei Geral de Proteção de Dados Pessoais (LGPD)',
    'Framework de conformidade com a Lei nº 13.709/2018 - LGPD. Abrange princípios, bases legais, direitos dos titulares, governança, segurança e resposta a incidentes.',
    'lgpd',
    TRUE,
    '1.0'
);

-- Dominios LGPD
INSERT INTO framework_domains (id, framework_id, name, description, order_index) VALUES
('a1000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', 'Princípios e Bases Legais', 'Fundamentos do tratamento de dados pessoais: princípios (art. 6°) e bases legais (art. 7° e 11°)', 1),
('a1000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001', 'Direitos dos Titulares', 'Mecanismos para atendimento aos direitos dos titulares previstos nos arts. 9°, 17 a 22', 2),
('a1000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000001', 'Governança e DPO', 'Estrutura de governança, indicação do DPO/Encarregado e programa de privacidade (arts. 37 a 45, 50)', 3),
('a1000000-0000-0000-0000-000000000004', 'a0000000-0000-0000-0000-000000000001', 'Segurança da Informação', 'Medidas técnicas e administrativas de segurança, boas práticas e governança (arts. 46 a 49)', 4),
('a1000000-0000-0000-0000-000000000005', 'a0000000-0000-0000-0000-000000000001', 'Registro de Operações e Relatórios', 'Registro das operações de tratamento, relatório de impacto (DPIA) e comunicação à ANPD (arts. 37, 38, 48)', 5),
('a1000000-0000-0000-0000-000000000006', 'a0000000-0000-0000-0000-000000000001', 'Resposta a Incidentes', 'Procedimentos para detecção, resposta e comunicação de incidentes de segurança (art. 48)', 6),
('a1000000-0000-0000-0000-000000000007', 'a0000000-0000-0000-0000-000000000001', 'Agentes de Tratamento e Contratos', 'Definição de controlador, operador, contratos e responsabilidades (arts. 37 a 42)', 7);

-- Controles LGPD
INSERT INTO controls (id, framework_id, domain_id, control_id, name, description, implementation_guidance, risk_level, control_type) VALUES

-- Dominio 1: Principios e Bases Legais
('a2000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-001',
 'Finalidade do Tratamento',
 'O tratamento deve ser realizado para finalidades legítimas, específicas, explícitas e informadas ao titular.',
 'Documentar a finalidade de cada operação de tratamento. Manter inventário atualizado. Revisar periodicamente.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-002',
 'Adequação do Tratamento',
 'Compatibilidade do tratamento com as finalidades informadas ao titular.',
 'Verificar se operações secundárias são compatíveis com a finalidade original. Documentar análise de compatibilidade.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-003',
 'Necessidade do Tratamento',
 'Limitacao do tratamento ao mínimo necessário para atingir a finalidade.',
 'Revisar periodicamente os dados coletados. Eliminar dados desnecessários. Implementar minimização nas coletas.', 'medium', 'organizational'),

('a2000000-0000-0000-0000-000000000004', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-004',
 'Livre Acesso',
 'Garantia de consulta facilitada e gratuita aos titulares sobre a forma e duração do tratamento.',
 'Implementar portal/ferramenta para consulta do titular. Disponibilizar informação clara sobre tratamento.', 'medium', 'technical'),

('a2000000-0000-0000-0000-000000000005', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-005',
 'Qualidade dos Dados',
 'Exatidão, clareza, relevância e atualização dos dados conforme necessidade.',
 'Implementar processos de validação e atualização periódica de dados. Corrigir dados inexatos.', 'medium', 'organizational'),

('a2000000-0000-0000-0000-000000000006', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-006',
 'Transparência',
 'Informação clara e acessível aos titulares sobre o tratamento de dados.',
 'Manter política de privacidade atualizada. Utilizar linguagem clara. Disponibilizar canais de informação.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000007', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-007',
 'Segurança e Prevenção',
 'Adoção de medidas para proteger dados de acessos não autorizados e situações acidentais ou ilícitas.',
 'Implementar controles de segurança (ver ISO 27001). Estabelecer política de segurança da informação.', 'critical', 'technical'),

('a2000000-0000-0000-0000-000000000008', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-008',
 'Não Discriminação',
 'Proibição de tratamento para fins discriminatórios.',
 'Revisar processos decisórios automatizados. Auditar algoritmos contra vieses discriminatórios.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000009', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-009',
 'Prestação de Contas',
 'Demonstração da adoção de medidas eficazes de compliance.',
 'Manter registros de todas as ações de compliance. Preparar relatórios periódicos para a alta direção.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000010', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-010',
 'Mapeamento de Bases Legais',
 'Identificação e documentação da base legal para cada operação de tratamento.',
 'Criar inventário de operações com base legal identificada. Revisar consentimentos periodicamente.', 'critical', 'organizational'),

('a2000000-0000-0000-0000-000000000011', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-011',
 'Consentimento',
 'Obtenção e gestão de consentimentos livres, informados e inequívocos.',
 'Implementar mecanismo de coleta de consentimento granular. Manter registro de consentimentos. Garantir revogação.', 'high', 'technical'),

('a2000000-0000-0000-0000-000000000012', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-012',
 'Tratamento de Dados Sensíveis',
 'Regras específicas para tratamento de dados sensíveis (art. 11).',
 'Identificar e classificar dados sensíveis. Implementar controles adicionais de acesso e segurança.', 'critical', 'organizational'),

-- Dominio 2: Direitos dos Titulares
('a2000000-0000-0000-0000-000000000013', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-013',
 'Confirmação e Acesso',
 'Garantia de confirmação da existência de tratamento e acesso aos dados.',
 'Implementar canal digital para solicitação de confirmação e acesso. Responder em até 15 dias.', 'high', 'technical'),

('a2000000-0000-0000-0000-000000000014', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-014',
 'Correção de Dados',
 'Mecanismo para solicitação de correção de dados incompletos, inexatos ou desatualizados.',
 'Disponibilizar canal para solicitação de correção. Processar correções em prazo adequado.', 'medium', 'technical'),

('a2000000-0000-0000-0000-000000000015', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-015',
 'Anonimização, Bloqueio e Eliminação',
 'Mecanismo para anonimizar, bloquear ou eliminar dados desnecessários ou tratados em desconformidade.',
 'Implementar procedimentos de anonimização e eliminação segura. Garantir que dados bloqueados não sejam processados.', 'high', 'technical'),

('a2000000-0000-0000-0000-000000000016', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-016',
 'Portabilidade',
 'Mecanismo para portabilidade dos dados a outro fornecedor, mediante requisição.',
 'Preparar dados em formato interoperável. Estabelecer procedimento para exportação.', 'medium', 'technical'),

('a2000000-0000-0000-0000-000000000017', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-017',
 'Eliminação e Revogação',
 'Mecanismo para eliminação dos dados após fim do tratamento e revogação de consentimento.',
 'Implementar política de retenção e eliminação. Garantir direito de revogação com mesma facilidade do consentimento.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000018', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-018',
 'Oposição e Revisão Automatizada',
 'Direito de opor-se ao tratamento e solicitar revisão de decisões automatizadas.',
 'Estabelecer processo para oposição. Implementar revisão humana para decisões automatizadas.', 'medium', 'organizational'),

-- Dominio 3: Governança e DPO
('a2000000-0000-0000-0000-000000000019', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-019',
 'Indicação do Encarregado (DPO)',
 'Nomeação de encarregado pelo tratamento de dados pessoais.',
 'Designar formalmente o DPO. Registrar na ANPD. Divulgar contato público do DPO.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000020', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-020',
 'Atividades do DPO',
 'Atuação do encarregado como canal de comunicação com titulares e ANPD.',
 'Definir responsabilidades do DPO. Garantir autonomia e recursos. Documentar atividades.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000021', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-021',
 'Programa de Governança em Privacidade',
 'Implementação de programa de governança em privacidade (art. 50).',
 'Estabelecer política de privacidade. Criar comitê de governança. Realizar treinamentos periódicos.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000022', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-022',
 'Treinamento e Conscientização',
 'Capacitação dos colaboradores sobre proteção de dados pessoais.',
 'Realizar treinamento inicial e periódico. Manter registro de participação. Adequar conteúdo por função.', 'medium', 'organizational'),

('a2000000-0000-0000-0000-000000000023', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-023',
 'Política de Privacidade',
 'Política de privacidade clara, acessível e atualizada.',
 'Redigir política em linguagem simples. Disponibilizar no site/app. Revisar anualmente.', 'high', 'organizational'),

-- Dominio 4: Segurança da Informação
('a2000000-0000-0000-0000-000000000024', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-024',
 'Medidas de Segurança Técnicas',
 'Adoção de medidas técnicas para proteção dos dados pessoais.',
 'Implementar criptografia em repouso e trânsito. Controle de acesso. Firewall. Antimalware. Monitoramento.', 'critical', 'technical'),

('a2000000-0000-0000-0000-000000000025', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-025',
 'Medidas de Segurança Administrativas',
 'Adoção de medidas administrativas para proteção dos dados pessoais.',
 'Políticas e procedimentos de segurança. Acordos de confidencialidade. Controles de acesso físico.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000026', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-026',
 'Controle de Acesso a Dados Pessoais',
 'Garantia de que apenas pessoas autorizadas acessam dados pessoais.',
 'Implementar RBAC. Revisar acessos periodicamente. Logar acessos a dados sensíveis.', 'critical', 'technical'),

('a2000000-0000-0000-0000-000000000027', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-027',
 'Criptografia e Pseudonimização',
 'Utilização de técnicas de criptografia e pseudonimização.',
 'Criptografar dados sensíveis. Utilizar pseudonimização quando possível. Gerenciar chaves com segurança.', 'high', 'technical'),

('a2000000-0000-0000-0000-000000000028', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-028',
 'Gestão de Riscos em Privacidade',
 'Processo contínuo de identificação e tratamento de riscos à privacidade.',
 'Realizar levantamento de riscos. Documentar plano de tratamento. Revisar periodicamente.', 'high', 'organizational'),

-- Dominio 5: Registro de Operações e Relatórios
('a2000000-0000-0000-0000-000000000029', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-029',
 'Registro das Operações de Tratamento (ROPA)',
 'Manutenção de registro das operações de tratamento de dados pessoais.',
 'Criar e manter ROPA atualizado. Incluir bases legais, finalidades, categorias de dados e prazos.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000030', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-030',
 'Relatório de Impacto à Proteção de Dados (DPIA)',
 'Elaboração de relatório de impacto para operações de alto risco.',
 'Identificar operações que exigem DPIA. Elaborar e manter relatórios. Revisar quando houver mudanças.', 'critical', 'organizational'),

('a2000000-0000-0000-0000-000000000031', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-031',
 'Comunicação à ANPD',
 'Comunicação de incidentes e solicitações da ANPD.',
 'Estabelecer canal com a ANPD. Manter modelo de comunicação de incidentes. Responder dentro dos prazos.', 'high', 'organizational'),

-- Dominio 6: Resposta a Incidentes
('a2000000-0000-0000-0000-000000000032', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-032',
 'Plano de Resposta a Incidentes',
 'Procedimentos para detecção, resposta e mitigação de incidentes de segurança.',
 'Criar e testar plano de resposta. Definir equipe de resposta. Estabelecer tempos de resposta.', 'critical', 'organizational'),

('a2000000-0000-0000-0000-000000000033', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-033',
 'Comunicação de Incidente aos Titulares',
 'Comunicação aos titulares sobre incidente que possa acarretar risco ou dano relevante.',
 'Definir template de comunicação. Estabelecer canais de notificação. Comunicar em prazo razoável.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000034', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-034',
 'Registro de Incidentes',
 'Registro detalhado de todos os incidentes de segurança.',
 'Manter log de incidentes. Documentar causa, impacto e ações corretivas. Revisar periodicamente.', 'medium', 'organizational'),

-- Dominio 7: Agentes de Tratamento e Contratos
('a2000000-0000-0000-0000-000000000035', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-035',
 'Contrato com Operadores',
 'Contratos formais com operadores que tratam dados em nome do controlador.',
 'Incluir cláusulas de proteção de dados nos contratos. Definir escopo e finalidade do tratamento.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000036', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-036',
 'Due Diligence de Operadores',
 'Avaliação de conformidade de operadores e suboperadores.',
 'Realizar avaliação prévia de operadores. Verificar medidas de segurança. Monitorar conformidade.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000037', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-037',
 'Transferência Internacional',
 'Conformidade com regras de transferência internacional de dados.',
 'Identificar transferências internacionais. Verificar adequação do país destino. Adotar cláusulas contratuais.', 'high', 'organizational'),

('a2000000-0000-0000-0000-000000000038', 'a0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'LGPD-038',
 'Compartilhamento com Terceiros',
 'Gestão do compartilhamento de dados com terceiros.',
 'Mapear compartilhamentos. Formalizar acordos. Informar titulares. Garantir base legal.', 'high', 'organizational');
