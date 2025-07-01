-- Limpiar datos previos para evitar duplicados
TRUNCATE TABLE "Application" CASCADE;
TRUNCATE TABLE "Candidate" CASCADE;
TRUNCATE TABLE "Position" CASCADE;
TRUNCATE TABLE "InterviewFlow" CASCADE;
TRUNCATE TABLE "Company" CASCADE;

-- Verificar la existencia de las tablas
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- Verificar columnas y tipos de datos en la tabla Company
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Company';

-- Insertar datos de prueba en la tabla Company
INSERT INTO "Company" ("name", "createdAt", "updatedAt") VALUES ('Test Company', NOW(), NOW());

-- Verificar columnas y tipos de datos en la tabla InterviewFlow
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'InterviewFlow';

-- Insertar datos de prueba en la tabla InterviewFlow
INSERT INTO "InterviewFlow" ("description", "createdAt", "updatedAt") 
VALUES ('Standard Interview Process', NOW(), NOW());

-- Verificar columnas y tipos de datos en la tabla Position
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Position';

-- Insertar datos de prueba en la tabla Position
INSERT INTO "Position" ("companyId", "interviewFlowId", "title", "status", "isVisible", "createdAt", "updatedAt") 
VALUES ((SELECT id FROM "Company" ORDER BY id DESC LIMIT 1), (SELECT id FROM "InterviewFlow" ORDER BY id DESC LIMIT 1), 'Software Engineer', 'Open', true, NOW(), NOW());

-- Verificar integridad referencial entre Position y Company
SELECT * FROM "Position" WHERE "companyId" = (SELECT id FROM "Company" ORDER BY id DESC LIMIT 1);

-- Verificar columnas y tipos de datos en la tabla Candidate
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Candidate';

-- Insertar datos de prueba en la tabla Candidate
INSERT INTO "Candidate" ("firstName", "lastName", "email", "createdAt", "updatedAt") 
VALUES ('Jane', 'Doe', 'jane.doe@example.com', NOW(), NOW());

-- Verificar columnas y tipos de datos en la tabla Application
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'Application';

-- Insertar datos de prueba en la tabla Application
INSERT INTO "Application" ("positionId", "candidateId", "applicationDate", "status", "createdAt", "updatedAt") 
VALUES ((SELECT id FROM "Position" ORDER BY id DESC LIMIT 1), (SELECT id FROM "Candidate" ORDER BY id DESC LIMIT 1), NOW(), 'Pending', NOW(), NOW());

-- Verificar integridad referencial entre Application y Position
SELECT * FROM "Application" WHERE "positionId" = (SELECT id FROM "Position" ORDER BY id DESC LIMIT 1);

-- Verificar índices únicos en la tabla Candidate
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'Candidate';

-- Verificar datos insertados en todas las tablas
SELECT * FROM "Company";
SELECT * FROM "InterviewFlow";
SELECT * FROM "Position";
SELECT * FROM "Candidate";
SELECT * FROM "Application";
