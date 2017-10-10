<?php

namespace Drupal\entity_atn_project;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\project\EntityOwnerInterface;
use Drupal\Core\Entity\EntityChangedInterface;

/**
 * Provides an interface defining a Project entity.
 *
 * We have this interface so we can join the other interfaces it extends.
 *
 * @ingroup entity_atn_project
 */
interface ProjectInterface extends ContentEntityInterface, EntityOwnerInterface, EntityChangedInterface {

}
