import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function RiscosPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Riscos</h1>
        <p className="text-muted-foreground">
          Identificação, análise e tratamento de riscos de segurança.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Risk Register</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Nenhum risco cadastrado. Inicie uma avaliação de riscos para mapear ameaças e
            definir planos de tratamento.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
