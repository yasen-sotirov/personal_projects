from core.application_data import ApplicationData
from models.gender import Gender
from commands.validation_helpers import validate_params_count, try_parse_float


class CreateToothpasteCommand:
    def __init__(self, params, app_data: ApplicationData):
        validate_params_count(params, 5)
        self._params = params
        self._app_data = app_data

    def execute(self):
        price = self._params[2]
        name = self._params[0]
        ingredients = self._params[4]
        if self._app_data.product_exists(name):
            raise ValueError(f"Toothpaste with name {name} already exists!")
        self._params[4] = self._params[4].split(",")
        gender = Gender.from_string(self._params[3])
        price = try_parse_float(price)
        self._app_data.create_toothpaste(*self._params)

        return f"Toothpaste with name {name} was created!"
