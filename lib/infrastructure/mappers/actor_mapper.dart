

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast) => Actor(id: cast.id, 
  name: cast.name,
   profilePath: cast.profilePath != null ?'https://image.tmdb.org/t/p/w500/${cast.profilePath}':
   'https://static.vecteezy.com/system/resources/previews/020/168/700/original/faceless-male-silhouette-empty-state-avatar-icon-businessman-editable-404-not-found-persona-for-ux-ui-design-cartoon-profile-picture-with-red-dot-colorful-website-mobile-error-user-badge-vector.jpg', 
   character: cast.character);
}