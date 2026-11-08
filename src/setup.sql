CREATE TABLE organization (
	organization_id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description TEXT NOT NULL,
	contact_email VARCHAR(255) NOT NULL,
	logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename) VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Project Table
-- ========================================
CREATE TABLE project (
    project_id      SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title           VARCHAR(150) NOT NULL,
    description     TEXT NOT NULL,
    location        VARCHAR(255) NOT NULL,
    date            DATE NOT NULL,
    CONSTRAINT fk_project_organization
        FOREIGN KEY (organization_id) REFERENCES organization (organization_id)
);


-- ========================================
-- Insert sample data: Projects
-- ========================================
INSERT INTO project (organization_id, title, description, location, date) VALUES
-- BrightFuture Builders (1)
(1, 'Community Center Roof Repair', 'Help replace damaged roofing panels at the neighborhood community center.', 'Riverside Community Center', '2026-12-05'),
(1, 'Accessible Ramp Build', 'Build wheelchair ramps for elderly and disabled residents.', 'Maple Street Homes', '2027-01-16'),
(1, 'Playground Restoration', 'Repair and repaint playground equipment at a local park.', 'Lincoln Park', '2027-02-20'),
(1, 'Habitat Home Framing', 'Assist with framing walls for a new affordable housing unit.', 'Oak Hollow Development', '2027-03-13'),
(1, 'Solar Lighting Installation', 'Install solar-powered lights along community walking paths.', 'Greenway Trail', '2027-04-10'),
-- GreenHarvest Growers (2)
(2, 'Winter Greenhouse Setup', 'Prepare the community greenhouse for winter vegetable growing.', 'Eastside Community Garden', '2026-12-12'),
(2, 'Composting Workshop', 'Teach families how to start and maintain a home compost system.', 'Public Library Meeting Room', '2027-01-23'),
(2, 'Seed Starting Day', 'Plant seedlings for the spring garden season.', 'GreenHarvest Urban Farm', '2027-02-27'),
(2, 'School Garden Build', 'Build raised garden beds for an elementary school.', 'Jefferson Elementary School', '2027-03-20'),
(2, 'Spring Harvest Market', 'Help run a farmers market that donates produce to food banks.', 'Downtown Plaza', '2027-04-24'),
-- UnityServe Volunteers (3)
(3, 'Holiday Food Drive', 'Collect and sort food donations for local families during the holidays.', 'UnityServe Warehouse', '2026-12-19'),
(3, 'Warm Coat Distribution', 'Distribute donated winter coats to families in need.', 'Central Community Hall', '2027-01-09'),
(3, 'Senior Center Visit', 'Spend an afternoon playing games and visiting with seniors.', 'Sunrise Senior Living', '2027-02-13'),
(3, 'Literacy Night', 'Read with children and help them choose free books to take home.', 'Westside Library', '2027-03-06'),
(3, 'Park Cleanup Day', 'Pick up litter and plant flowers at a city park.', 'Riverside Park', '2027-04-17');


-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- Project-Category Junction Table (many-to-many)
-- ========================================
CREATE TABLE project_category (
    project_id  INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project_category_project
        FOREIGN KEY (project_id) REFERENCES project (project_id),
    CONSTRAINT fk_project_category_category
        FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (name) VALUES
('Environmental'),
('Educational'),
('Community Service'),
('Health and Wellness');


-- ========================================
-- Insert sample data: Project categories
-- 1 Environmental, 2 Educational, 3 Community Service, 4 Health and Wellness
-- ========================================
INSERT INTO project_category (project_id, category_id) VALUES
(1, 3),            -- Community Center Roof Repair
(2, 3), (2, 4),    -- Accessible Ramp Build
(3, 3), (3, 4),    -- Playground Restoration
(4, 3),            -- Habitat Home Framing
(5, 1), (5, 3),    -- Solar Lighting Installation
(6, 1),            -- Winter Greenhouse Setup
(7, 1), (7, 2),    -- Composting Workshop
(8, 1),            -- Seed Starting Day
(9, 1), (9, 2),    -- School Garden Build
(10, 3), (10, 4),  -- Spring Harvest Market
(11, 3),           -- Holiday Food Drive
(12, 3),           -- Warm Coat Distribution
(13, 4),           -- Senior Center Visit
(14, 2),           -- Literacy Night
(15, 1), (15, 3);  -- Park Cleanup Day