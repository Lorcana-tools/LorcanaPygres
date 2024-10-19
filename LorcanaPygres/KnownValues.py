from utils import query_db


class KnownValues():
    def __init__(self):
        self._rarity_tags = self._get_rarity_tags()
        self._ink_tags = self._get_ink_tags()
        self._type_tags = self._get_type_tags()
        self._card_subtypes = self._get_card_subtypes()
        self._card_artists = self._get_card_artists()
        self._card_abilities = self._get_card_abilities()
        self._foil_types = self._get_foil_types()
        self._varnish_types = self._get_varnish_types()
        self._image_sizes = self._get_image_sizes()
        self._card_types = self._get_card_types()

    def trigger_refresh(self):
        self._rarity_tags = self._get_rarity_tags()
        self._ink_tags = self._get_ink_tags()
        self._type_tags = self._get_type_tags()
        self._card_subtypes = self._get_card_subtypes()
        self._card_artists = self._get_card_artists()
        self._card_abilities = self._get_card_abilities()
        self._foil_types = self._get_foil_types()
        self._varnish_types = self._get_varnish_types()
        self._image_sizes = self._get_image_sizes()
        self._card_types = self._get_card_types()

    def _get_card_types(self):
        all_tags = []
        query = query_db(f"SELECT id card_type_id, card_type FROM card_types")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            card_type, card_type_id = query['card_type'][i], int(query['card_type_id'][i])
            all_tags.append([card_type, card_type_id])
            i += 1
        return all_tags

    def get_card_type_id(self, card_type):
        for tag in self._card_types:
            if tag[0] == card_type:
                return tag[1]
        return None

    def _get_image_sizes(self):
        all_tags = []
        query = query_db(f"SELECT id image_size_id, image_size FROM card_image_sizes")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            image_size, image_size_id = query['image_size'][i], int(query['image_size_id'][i])
            all_tags.append([image_size, image_size_id])
            i += 1
        return all_tags

    def get_image_size_id(self, image_size):
        for tag in self._image_sizes:
            if tag[0] == image_size:
                return tag[1]
        return None

    def _get_foil_types(self):
        all_tags = []
        query = query_db(f"SELECT id foil_type_id, foil_type FROM foil_types")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            foil_type, foil_type_id = query['foil_type'][i], int(query['foil_type_id'][i])
            all_tags.append([foil_type, foil_type_id])
            i += 1
        return all_tags

    def get_foil_type_id(self, foil_type):
        for tag in self._foil_types:
            if tag[0] == foil_type:
                return tag[1]
        return None

    def _get_varnish_types(self):
        all_tags = []
        query = query_db(f"SELECT id varnish_type_id, varnish_type FROM varnish_types")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            varnish_type, varnish_type_id = query['varnish_type'][i], int(query['varnish_type_id'][i])
            all_tags.append([varnish_type, varnish_type_id])
            i += 1
        return all_tags

    def get_varnish_type_id(self, varnish_type):
        for tag in self._varnish_types:
            if tag[0] == varnish_type:
                return tag[1]
        return None

    def _get_rarity_tags(self):
        all_tags = []
        query = query_db(f"SELECT id rarity_id, rarity FROM card_rarities")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            rarity, rarity_id = query['rarity'][i], int(query['rarity_id'][i])
            all_tags.append([rarity, rarity_id])
            i += 1
        return all_tags

    def get_rarity_id(self, rarity):
        for tag in self._rarity_tags:
            if tag[0] == rarity:
                return tag[1]
        return None

    def _get_ink_tags(self):
        all_tags = []
        query = query_db(f"SELECT id ink_id, ink_color FROM card_ink")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            ink_id, ink_color = int(query['ink_id'][i]), query['ink_color'][i]
            all_tags.append([ink_color, ink_id])
            i += 1
        return all_tags

    def get_ink_id(self, ink):
        for tag in self._ink_tags:
            if tag[0] == ink:
                return tag[1]
        return None

    def _get_type_tags(self):
        all_tags = []
        query = query_db(f"SELECT id type_id, card_type FROM card_types")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            type_id, card_type = int(query['type_id'][i]), query['card_type'][i]
            all_tags.append([card_type, type_id])
            i += 1
        return all_tags

    def get_type_id(self, type_name):
        for tag in self._type_tags:
            if tag[0] == type_name:
                return tag[1]
        return None

    def _get_card_subtypes(self):
        all_tags = []
        query = query_db(f"SELECT id subtype_id, card_subtype FROM card_subtypes")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            subtype_id, card_subtype = int(query['subtype_id'][i]), query['card_subtype'][i]
            all_tags.append([card_subtype, subtype_id])
            i += 1
        return all_tags

    def get_card_subtype_id(self, class_name):
        for tag in self._card_subtypes:
            if tag[0] == class_name:
                return tag[1]
        return None

    def get_artist_id(self, artist):
        for tag in self._card_artists:
            if tag[0] == artist:
                return tag[1]
        return None

    def _get_card_artists(self):
        all_tags = []
        query = query_db(f"SELECT id artist_id, artist_name FROM card_artists")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            artist_id, artist_name = int(query['artist_id'][i]), query['artist_name'][i]
            all_tags.append([artist_name, artist_id])
            i += 1
        return all_tags

    def get_card_ability_id(self, ability):
        for tag in self._card_abilities:
            if tag[0] == ability:
                return tag[1]
        return None

    def _get_card_abilities(self):
        all_tags = []
        query = query_db(f"SELECT id ability_id, ability FROM card_abilities")
        if len(query) == 0:
            return all_tags
        i = 0
        while i < len(query):
            ability_id, ability = int(query['ability_id'][i]), query['ability'][i]
            all_tags.append([ability, ability_id])
            i += 1
        return all_tags


test = KnownValues()
test._card_abilities
test.get_card_ability_id('Rush')
