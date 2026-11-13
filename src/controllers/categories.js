// Import any needed model functions
import { getAllOrganizations, getOrganizationDetails } from '../models/organizations.js';  
import { getProjectsByOrganizationId } from '../models/projects.js'; 

// Define any controller functions
const showCategoriesPage = async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Project Categories';

    res.render('categories', { title, categories });
};

const showOrganizationDetailsPage = async (req, res, next) => {
    const organizationId = req.params.id;
    const organizationDetails = await getOrganizationDetails(organizationId);

    if (!organizationDetails) {
        const err = new Error('Organization Not Found');
        err.status = 404;
        return next(err);
    }

    const projects = await getProjectsByOrganizationId(organizationId);
    const title = 'Organization Details';

    res.render('organization', { title, organizationDetails, projects });
}; 

// Export any controller functions
export { showOrganizationsPage, showOrganizationDetailsPage };
