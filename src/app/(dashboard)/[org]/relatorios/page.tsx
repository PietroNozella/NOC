import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function RelatoriosPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Relatórios</h1>
        <p className="text-muted-foreground">
          Relatórios de status de compliance e gap analysis.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Relatórios Disponíveis</CardTitle>
        </CardHeader>
        <CardContent>
          <ul className="space-y-2 text-sm text-muted-foreground">
            <li>• Status de Compliance por Framework</li>
            <li>• Gap Analysis (controles não avaliados)</li>
            <li>• Resumo de Evidências</li>
            <li>• Risk Register</li>
            <li>• Histórico de Auditorias</li>
          </ul>
        </CardContent>
      </Card>
    </div>
  );
}
