# Drupal CMS

Drupal CMS is a fast-moving open source product that enables site builders to easily create new Drupal sites and extend them with smart defaults, all using their browser.

## Development Environment

### Local Development with DDEV

This project uses [DDEV](https://ddev.com) for local development. To get started:

1. Install DDEV following the [documentation](https://ddev.com/get-started/)
2. Clone this repository
3. Open the command line and `cd` to the root directory of this project
4. Run the command `./launch-drupal-cms.sh`

The Drupal CMS installer offers a list of features preconfigured with smart defaults. You can customize and add additional features after logging in.

### Production Deployment with Coolify

This project includes configuration for deploying to [Coolify](https://coolify.io/), a self-hosted Heroku/Netlify alternative.

#### Quick Start

1. Set up a Coolify server following their [documentation](https://coolify.io/docs)
2. In Coolify dashboard:
   - Create new service
   - Select "Docker Compose" deployment type
   - Connect your Git repository
   - Set Docker Compose file location to `.coolify/docker-compose.yml`
   - Configure environment variables from `.coolify/.env.example`

#### Detailed Instructions

See [.coolify/DEPLOY.md](.coolify/DEPLOY.md) for comprehensive deployment instructions, including:
- Complete environment variable configuration
- Persistent storage setup
- Database administration
- SSL/TLS configuration
- Monitoring and maintenance

#### Key Features

The Coolify deployment includes:
- PHP 8.3 with optimized settings
- MariaDB database
- Redis caching
- phpMyAdmin for database management
- Automatic Composer dependency installation
- SSL/TLS certificate management

## Documentation

Coming soon ... [We're working on Drupal CMS specific documentation](https://www.drupal.org/project/drupal_cms/issues/3454527).

In the meantime, learn more about managing a Drupal-based application in the [Drupal User Guide](https://www.drupal.org/docs/user_guide/en/index.html).

## Contributing

Drupal CMS is developed in the open on [Drupal.org](https://www.drupal.org). We are grateful to the community for reporting bugs and contributing fixes and improvements.

[Report issues in the queue](https://drupal.org/node/add/project-issue/drupal_cms), providing as much detail as you can. You can also join the #drupal-cms-support channel in the [Drupal Slack community](https://www.drupal.org/slack).

Drupal CMS has adopted a [code of conduct](https://www.drupal.org/dcoc) that we expect all participants to adhere to.

To contribute to Drupal CMS development, see the [drupal_cms project](https://www.drupal.org/project/drupal_cms).

## License

Drupal CMS and all derivative works are licensed under the [GNU General Public License, version 2 or later](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html).

Learn about the [Drupal trademark and logo policy here](https://www.drupal.com/trademark).
