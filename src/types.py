from pydantic import BaseModel

ServiceName = str
ServiceId = str


class LinkInfo(BaseModel):
    service: ServiceName
    clean_url: str
    type: str
    id: ServiceId
