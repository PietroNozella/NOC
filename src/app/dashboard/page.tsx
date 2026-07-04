import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";

export default async function DashboardRedirect() {
  const supabase = await createClient();

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");

  const { data: profile } = await supabase
    .from("profiles")
    .select("organization_id")
    .eq("id", user.id)
    .single();

  if (!profile) redirect("/login");

  const { data: org } = await supabase
    .from("organizations")
    .select("slug")
    .eq("id", profile.organization_id)
    .single();

  if (!org) redirect("/login");

  redirect(`/${org.slug}/dashboard`);
}
