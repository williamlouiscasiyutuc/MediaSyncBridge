from ..utils.load_dotenv import load_env_to_environ
from .igdb import IgdbAPI
from .kinopoisk import KinopoiskAPI
from .shikimori import ShikimoriAPI

load_env_to_environ()
__all__ = [
    "IgdbAPI",
    "KinopoiskAPI",
    "ShikimoriAPI",
]
