# Deploying to Coolify

This guide explains how to deploy this Drupal CMS project using Coolify while maintaining compatibility with DDEV for local development.

## Project Structure

The deployment configuration is isolated in the `.coolify` directory to avoid conflicts with DDEV:
```
.coolify/
  ├── docker-compose.yml    # Production Docker configuration (must be specified in Coolify settings)
  ├── nginx/               # Nginx configuration
  │   └── default.conf
  └── .env                # Production environment variables
```

Note: By default, Coolify looks for docker-compose.yml in the root directory. This project intentionally keeps the production configuration in the .coolify directory to avoid conflicts with DDEV. You must explicitly set the Docker Compose file location to `.coolify/docker-compose.yml` in your Coolify service settings.

## Prerequisites

1. A server with Coolify installed
2. Git repository with your project
3. Access to your Coolify dashboard

## Deployment Steps

1. **Login to Coolify Dashboard**
   - Access your Coolify dashboard
   - Navigate to "Applications" section

2. **Create New Service**
   - Click "New Service"
   - Select "Docker Compose" as deployment type
   - Connect your Git repository
   - **IMPORTANT**: In the service configuration:
     * Find the "Docker Compose File Location" field
     * Set it to `.coolify/docker-compose.yml`
     * This step is crucial as Coolify will look for docker-compose.yml in the root by default

3. **Environment Variable Setup**
   
   a. Create Production Environment File:
   - Copy `.coolify/.env.example` to `.coolify/.env`
   - Update with your production values
   - Never commit `.coolify/.env` to Git

   b. Configure in Coolify Dashboard:
   - Go to your application settings
   - Navigate to "Environment Variables" section
   - Add each variable from your `.coolify/.env` file:

   Required Variables:
   ```
   DB_NAME=drupal
   DB_USER=drupal
   DB_PASSWORD=<strong-password>        # Change this!
   DB_ROOT_PASSWORD=<strong-root-pass>  # Change this!
   
   # Port configuration
   NGINX_PORT=8080
   PMA_PORT=8081
   
   # PHP settings
   PHP_MEMORY_LIMIT=256M
   PHP_MAX_EXECUTION_TIME=120
   PHP_UPLOAD_MAX_FILESIZE=100M
   PHP_POST_MAX_SIZE=100M
   
   # Redis settings
   REDIS_HOST=redis
   REDIS_PORT=6379
   ```

   Optional Production Variables:
   ```
   # Domain configuration
   TRUSTED_HOST_PATTERNS="^example\.com$,^www\.example\.com$"
   BASE_URL=https://example.com

   # SMTP settings (if using email)
   SMTP_HOST=smtp.example.com
   SMTP_PORT=587
   SMTP_USER=your_smtp_user
   SMTP_PASS=your_smtp_password
   ```

   Security Notes:
   - Use strong, unique passwords for database credentials
   - Keep SMTP and other sensitive credentials secure
   - Consider using Coolify's secret manager for sensitive values

4. **Configure Persistent Storage**
   Add the following storage mounts in Coolify:
   - `/opt/drupal/web/sites/default/files` for Drupal files
   - `/opt/drupal/vendor` for Composer dependencies
   - `/opt/drupal/web/core` for Drupal core
   - `/opt/drupal/web/modules/contrib` for contributed modules
   - `/opt/drupal/web/themes/contrib` for contributed themes
   - `/opt/drupal/web/profiles/contrib` for contributed profiles
   - `/opt/drupal/web/libraries` for libraries
   - `/var/lib/mysql` for database
   - `/data` for Redis

   Note: The deployment process will automatically run `composer install` during container initialization to install all dependencies.

5. **Configure Database Administration**
   phpMyAdmin is included for database management:
   - Access phpMyAdmin at port 8081 of your domain (or custom port set in PMA_PORT)
   - Login using either:
     * Root credentials: username `root`, password from `DB_ROOT_PASSWORD`
     * Drupal database user: username from `DB_USER`, password from `DB_PASSWORD`
   - For security, consider:
     * Changing the default port in the environment variables
     * Setting up HTTP Basic Authentication
     * Restricting access to specific IP addresses

6. **Deploy**
   - Click "Deploy" to start the deployment process
   - Coolify will use the configuration from .coolify/docker-compose.yml

## Local Development vs Production

This setup maintains a clear separation between:

1. **Local Development (DDEV)**
   - Uses DDEV's own docker-compose configuration
   - Managed through `ddev` commands
   - Configuration in `.ddev` directory

2. **Production Deployment (Coolify)**
   - Uses configuration in `.coolify` directory
   - Managed through Coolify dashboard
   - Separate environment variables and ports

This separation ensures that:
- No conflicts between development and production configurations
- DDEV commands work as expected locally
- Production deployment remains isolated and secure
- Composer dependencies are properly managed in production
- Git repository stays clean (vendor, core, and contributed code are ignored)

## Post-Deployment

1. **Access Your Site**
   - Once deployed, access your site through the provided URL
   - Complete the Drupal installation process through the web interface

2. **SSL/TLS Configuration**
   - Configure your domain in Coolify
   - Enable SSL/TLS certificate (Coolify handles Let's Encrypt automatically)

3. **Monitoring**
   - Use Coolify's built-in monitoring to keep track of your services
   - Set up notifications for important events

## Maintenance

- **Backups**: Configure database backups in Coolify's backup section
- **Updates**: Use Coolify's automatic updates feature for container images
- **Logs**: Access logs through Coolify's dashboard for troubleshooting

## Troubleshooting

If you encounter issues:
1. Check the container logs in Coolify dashboard
2. Verify environment variables are set correctly
3. Ensure persistent storage is properly configured
4. Check Drupal's status report page for any warnings or errors

For additional help, refer to:
- [Coolify Documentation](https://coolify.io/docs)
- [Drupal Documentation](https://www.drupal.org/docs)
- [DDEV Documentation](https://ddev.readthedocs.io/)
