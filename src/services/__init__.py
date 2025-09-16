from .base import Service
from .igdb import IgdbService
from .imdb import ImdbService
from .kinopoisk import KinopoiskService
from .shikimori import ShikimoriService
from .steam import SteamService

__all__ = [
    "Service",
    "KinopoiskService",
    "IgdbService",
    "ShikimoriService",
    "ImdbService",
    "SteamService",
]
