import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function AuditoriasPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Auditorias</h1>
        <p className="text-muted-foreground">
          Ciclos de auditoria, achados e planos de ação.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Ciclos de Auditoria</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Nenhuma auditoria cadastrada. Planeje ciclos de auditoria interna e externa para
            seus frameworks de compliance.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
