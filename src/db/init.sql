CREATE TABLE "alarms"(
    "id" UUID NOT NULL,
    "system_id" UUID NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "alarms" ADD PRIMARY KEY("id");
CREATE TABLE "users"(
    "id" UUID NOT NULL,
    "username" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_username_unique" UNIQUE("username");
CREATE TABLE "users_sites"(
    "user_id" UUID NOT NULL,
    "site_id" UUID NOT NULL
);
ALTER TABLE
    "users_sites" ADD CONSTRAINT "users_sites_site_id_user_id_unique" UNIQUE("site_id", "user_id");
CREATE TABLE "sites"(
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL
);
ALTER TABLE
    "sites" ADD PRIMARY KEY("id");
CREATE TABLE "systems"(
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "site_id" UUID NOT NULL
);
ALTER TABLE
    "systems" ADD PRIMARY KEY("id");
ALTER TABLE
    "users_sites" ADD CONSTRAINT "users_sites_site_id_foreign" FOREIGN KEY("site_id") REFERENCES "sites"("id");
ALTER TABLE
    "systems" ADD CONSTRAINT "systems_site_id_foreign" FOREIGN KEY("site_id") REFERENCES "sites"("id");
ALTER TABLE
    "users_sites" ADD CONSTRAINT "users_sites_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "alarms" ADD CONSTRAINT "alarms_system_id_foreign" FOREIGN KEY("system_id") REFERENCES "systems"("id");


-- Users: john, matthew, jane
--- username: "john", password: "J0hnY329!2%"
INSERT INTO public.users
(id, username, password_hash)
VALUES('2feb7c4d-d5a6-4915-a3cb-4cbdc49dced8', 'john', '$2b$12$CSAOxFyvTs7z7KX6CxHfR.CR.TObqclBn0s75Yyprvb9YEDavx9Hy');
--- username: "matthew", password: "m4tTh333w90!"
INSERT INTO public.users
(id, username, password_hash)
VALUES('ab47fa93-cb81-4ee1-b9fe-125c5c5a1638', 'matthew', '$2b$12$2FhB4O8XZS0ciIroziLwdeVg/LUhdSsEXvaJHvYULfNxht0khFdcS');
--- username: "jane", password: "J4n37%D03!"
INSERT INTO public.users
(id, username, password_hash)
VALUES('e397d049-7045-4966-9cc3-12ce8b824618', 'jane', '$2b$12$wn/J0B546Ok1ObrWpceRNODd9Rntic0JpyjmmpTvTMnPqtdIRAvV2');

-- Sites: School, Hospital, Hotel, Ship, Supermarket
INSERT INTO public.sites
(id, "name")
VALUES('f13a3947-34d6-4091-93f2-0a0928dfc8bf', 'School');
INSERT INTO public.sites
(id, "name")
VALUES('f7ded5d5-6c7f-4c96-ad86-a9584dba66c1', 'Hospital');
INSERT INTO public.sites
(id, "name")
VALUES('687f919d-1d35-477f-93f7-abb7cb9d5546', 'Hotel');
INSERT INTO public.sites
(id, "name")
VALUES('057e5f8a-d5fd-483f-a3f1-a5d331fd67e2', 'Ship');
INSERT INTO public.sites
(id, "name")
VALUES('966edbf2-9943-488d-baa5-180538d72ff4', 'Supermarket');

-- Sites users

--- Site: School, users: john, jane
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('2feb7c4d-d5a6-4915-a3cb-4cbdc49dced8', 'f13a3947-34d6-4091-93f2-0a0928dfc8bf');
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('e397d049-7045-4966-9cc3-12ce8b824618', 'f13a3947-34d6-4091-93f2-0a0928dfc8bf');

--- Site: Hospital, users: john
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('2feb7c4d-d5a6-4915-a3cb-4cbdc49dced8', 'f7ded5d5-6c7f-4c96-ad86-a9584dba66c1');

--- Site: Hotel, users: john, matthew
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('2feb7c4d-d5a6-4915-a3cb-4cbdc49dced8', '687f919d-1d35-477f-93f7-abb7cb9d5546');
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('ab47fa93-cb81-4ee1-b9fe-125c5c5a1638', '687f919d-1d35-477f-93f7-abb7cb9d5546');

--- Site: Ship, users: matthew, jane
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('ab47fa93-cb81-4ee1-b9fe-125c5c5a1638', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('e397d049-7045-4966-9cc3-12ce8b824618', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');

--- Site: Supermarket, users: jane
INSERT INTO public.users_sites
(user_id, site_id)
VALUES('e397d049-7045-4966-9cc3-12ce8b824618', '966edbf2-9943-488d-baa5-180538d72ff4');

-- Systems: School, Hospital, Hotel, Ship, Supermarket

--- Site: School, systems: Basement, 0 floor
INSERT INTO public.systems
(id, "name", site_id)
VALUES('a9f373e6-db36-4f96-af64-31396a256b8e', 'Basement', 'f13a3947-34d6-4091-93f2-0a0928dfc8bf');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('b05b64dd-f0dd-4894-a4f4-b10a2510f4e4', 'a9f373e6-db36-4f96-af64-31396a256b8e', true);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('ada19b80-cc31-4cb0-934f-ba3c11ae8c08', '0 floor', 'f13a3947-34d6-4091-93f2-0a0928dfc8bf');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('b121547b-cbd1-422a-a6ef-1d3d46907446', 'ada19b80-cc31-4cb0-934f-ba3c11ae8c08', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('45c8f2ec-8c2e-4614-81b3-65d0bbd311db', 'ada19b80-cc31-4cb0-934f-ba3c11ae8c08', false);

--- Site: Hospital, systems: Guard system
INSERT INTO public.systems
(id, "name", site_id)
VALUES('1f3b8250-bf46-4e03-b5be-d9b1c62a0187', 'Guard system', 'f7ded5d5-6c7f-4c96-ad86-a9584dba66c1');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('41a01c8a-7c3d-4a51-8049-7700356b8fca', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('46de9707-958c-4299-9fc2-773d529f37fa', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('8e659cd8-3d88-4d39-8b61-5a6e2c35ebcd', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('4ff0e5e7-c77d-4002-8a6d-f15a561ea840', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('ef5b0714-acec-4f87-919f-bd210602b212', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('10643619-76d7-434e-8e5d-82c18273109f', '1f3b8250-bf46-4e03-b5be-d9b1c62a0187', false);

--- Site: Hotel, systems: Ground floor, Luxury apartments, Reception
INSERT INTO public.systems
(id, "name", site_id)
VALUES('c05b101e-9194-4888-b579-1f4ad4813dc5', 'Ground floor', '687f919d-1d35-477f-93f7-abb7cb9d5546');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('332b0e07-19bb-4abe-8c69-6301cf312a27', 'c05b101e-9194-4888-b579-1f4ad4813dc5', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('0cc49ad6-fa20-4b92-88ed-0498bef2718e', 'c05b101e-9194-4888-b579-1f4ad4813dc5', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('7e675a6f-bc87-402d-9cad-4f6795ce8cfc', 'c05b101e-9194-4888-b579-1f4ad4813dc5', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('7f586240-c9b8-4ecf-9083-32fa2ab00228', 'c05b101e-9194-4888-b579-1f4ad4813dc5', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('9bddea9e-9f7c-487c-ba65-4b88c7f2cf3a', 'c05b101e-9194-4888-b579-1f4ad4813dc5', false);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('44867b95-3568-42e6-8e53-ddbd113db3a4', 'Luxury apartments', '687f919d-1d35-477f-93f7-abb7cb9d5546');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('908aa42f-06ab-45c6-bba3-8bc5fc8ef748', '44867b95-3568-42e6-8e53-ddbd113db3a4', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('5727ada0-1535-447e-9dd3-10c2f86d99ae', '44867b95-3568-42e6-8e53-ddbd113db3a4', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('6ac33dad-0a8b-4a61-9b61-0bb7e29c72d7', '44867b95-3568-42e6-8e53-ddbd113db3a4', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('6d232f66-5261-42a8-a329-d8b763755ae9', '44867b95-3568-42e6-8e53-ddbd113db3a4', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('2853c74e-4d55-4880-868a-4c58417724c2', '44867b95-3568-42e6-8e53-ddbd113db3a4', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('6371d7ea-acaf-4228-85a3-cd80e203af1f', '44867b95-3568-42e6-8e53-ddbd113db3a4', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('b0482436-c9f3-4697-9e80-f47099d00af5', '44867b95-3568-42e6-8e53-ddbd113db3a4', false);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('2f7a8ee6-3baa-45df-8c48-6912b1a6150d', 'Reception', '687f919d-1d35-477f-93f7-abb7cb9d5546');

--- Site: Ship, systems: Pumps, Engine room, Deck, Engine back-up, Bridge
INSERT INTO public.systems
(id, "name", site_id)
VALUES('d95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', 'Pumps', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('b2ec95fc-6184-4920-b20d-9acd449d2492', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('0a4994b5-151f-402a-bc5d-1e770d0d971f', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('52ff553d-ac49-44b6-8254-4ac3bf0cc4e9', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('2f8ee4ab-0d28-4c33-9f9f-cf7b1f514aa4', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('64b01b2f-3597-4360-9c55-15889abd8da3', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('9488e115-436b-4be2-b723-877998d70f9c', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('bfb78d3e-4fb7-4e54-97ee-6917e6469513', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('f3872343-49a5-4823-9c5e-3b632b26dcdd', 'd95597cc-fe90-4c05-bfe1-0f0c3c2c62e1', false);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('6b6067f2-eb62-492f-ae1a-0f5bd5c9cea7', 'Engine room', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('55b8ef11-05d7-4b0b-a109-7a87d4ad653d', '6b6067f2-eb62-492f-ae1a-0f5bd5c9cea7', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('131fc96b-c2b2-4b61-801a-bcf704df569a', '6b6067f2-eb62-492f-ae1a-0f5bd5c9cea7', true);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', 'Deck', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('74540c75-8da5-4428-920c-c032b49d5728', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('0d61bd67-f61e-402b-9e02-9b94059321b7', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('fc2baff9-3bd7-4b83-8636-c4fa47a61ed0', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('54636ddc-0206-498c-8c3e-59d3717ae5e0', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('46c4d179-4980-4415-867c-b39c52804c95', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('e50018e2-2477-4831-96b3-28def30948d7', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('0a1bdb55-9e5e-42fd-bcf1-56b2be3f1e42', 'ae6e835d-1217-4b9b-a1e9-f29fe1f89e1e', true);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('d0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', 'Engine back-up', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('639c1cc9-728d-4b98-a36b-158a809da977', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('de6b144a-883d-4c45-b372-53fab5aa082f', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('2eb26534-364d-4b18-b676-e2b699509c33', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('f9b96168-c1a0-4cc5-a157-daa0aef3a817', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('f9f171e2-3f59-4cce-9916-9b0c4308606b', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('d5ac0382-67e5-41ae-b656-c4d1dc430e2b', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('c7f15f44-2ff1-4b44-b4b5-2af49ba1e720', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('56c7783a-481c-4475-b4a9-209e45314197', 'd0d70ce4-a530-41c1-bd75-4cbaa7f91c7f', true);
INSERT INTO public.systems
(id, "name", site_id)
VALUES('2f5b31cd-a447-40d4-84dd-00b1770e7618', 'Bridge', '057e5f8a-d5fd-483f-a3f1-a5d331fd67e2');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('e698a56d-c99d-47cf-bbe4-920621202457', '2f5b31cd-a447-40d4-84dd-00b1770e7618', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('5a409df9-cc1c-45d4-ba95-ee87a7478939', '2f5b31cd-a447-40d4-84dd-00b1770e7618', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('0a2bf94a-03a0-4f7d-b0fe-ddddea307e89', '2f5b31cd-a447-40d4-84dd-00b1770e7618', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('224f2774-3cae-42d1-b8fa-9f35b7338d06', '2f5b31cd-a447-40d4-84dd-00b1770e7618', false);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('f9f7a001-8adb-4a5a-a3e7-f27ed4162485', '2f5b31cd-a447-40d4-84dd-00b1770e7618', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('a6dc0d3f-a1e9-46af-b447-3049c5295089', '2f5b31cd-a447-40d4-84dd-00b1770e7618', false);

--- Site: Supermarket, systems: Public zone, Private zone
INSERT INTO public.systems
(id, "name", site_id)
VALUES('207a948d-478d-4c9e-868b-a6fb8de84ac0', 'Public zone', '966edbf2-9943-488d-baa5-180538d72ff4');
INSERT INTO public.systems
(id, "name", site_id)
VALUES('d29fbc14-1e38-465f-bd5b-61616046ca4b', 'Private zone', '966edbf2-9943-488d-baa5-180538d72ff4');
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('650d0987-13cc-4a16-a561-d85796f45e51', 'd29fbc14-1e38-465f-bd5b-61616046ca4b', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('c16ee566-7a51-4fda-96ea-d1a3556f4979', 'd29fbc14-1e38-465f-bd5b-61616046ca4b', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('6adcc762-a82d-49c0-b882-359aa5f97b8b', 'd29fbc14-1e38-465f-bd5b-61616046ca4b', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('905cec63-c824-4f5a-9655-9d495a48befa', 'd29fbc14-1e38-465f-bd5b-61616046ca4b', true);
INSERT INTO public.alarms
(id, system_id, is_active)
VALUES('43873262-db55-4f78-b6f7-5bf6e042d7d1', 'd29fbc14-1e38-465f-bd5b-61616046ca4b', false);
