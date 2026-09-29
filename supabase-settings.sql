-- Noemia Store: configuração partilhada entre painel e loja pública
create table if not exists public.store_settings (
  id integer primary key check (id = 1),
  whatsapp text not null default '244931909269',
  email text not null default 'noemiastorecontact@gmail.com',
  updated_at timestamptz not null default now()
);
insert into public.store_settings (id, whatsapp, email)
values (1, '244931909269', 'noemiastorecontact@gmail.com')
on conflict (id) do nothing;
alter table public.store_settings enable row level security;
drop policy if exists "Public can read store settings" on public.store_settings;
create policy "Public can read store settings" on public.store_settings
  for select to anon, authenticated using (true);
drop policy if exists "Authenticated admins manage store settings" on public.store_settings;
create policy "Authenticated admins manage store settings" on public.store_settings
  for all to authenticated using (true) with check (true);
