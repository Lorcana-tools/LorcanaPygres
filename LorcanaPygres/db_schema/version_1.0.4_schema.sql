--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: card_abilities; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_abilities (
    id integer NOT NULL,
    ability character varying NOT NULL
);


ALTER TABLE public.card_abilities OWNER TO lorcana_33;

--
-- Name: card_abilities_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_abilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_abilities_id_seq OWNER TO lorcana_33;

--
-- Name: card_abilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_abilities_id_seq OWNED BY public.card_abilities.id;


--
-- Name: card_ability_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_ability_map (
    id integer NOT NULL,
    ability_id integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_ability_map OWNER TO lorcana_33;

--
-- Name: card_ability_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_ability_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_ability_map_id_seq OWNER TO lorcana_33;

--
-- Name: card_ability_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_ability_map_id_seq OWNED BY public.card_ability_map.id;


--
-- Name: card_additional_info; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_additional_info (
    id integer NOT NULL,
    additional_info character varying NOT NULL,
    card_id integer NOT NULL,
    info_type character varying NOT NULL
);


ALTER TABLE public.card_additional_info OWNER TO lorcana_33;

--
-- Name: card_additional_details_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_additional_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_additional_details_id_seq OWNER TO lorcana_33;

--
-- Name: card_additional_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_additional_details_id_seq OWNED BY public.card_additional_info.id;


--
-- Name: card_artist_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_artist_map (
    id integer NOT NULL,
    artist_id integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_artist_map OWNER TO lorcana_33;

--
-- Name: card_artist_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_artist_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_artist_map_id_seq OWNER TO lorcana_33;

--
-- Name: card_artist_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_artist_map_id_seq OWNED BY public.card_artist_map.id;


--
-- Name: card_artists; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_artists (
    id integer NOT NULL,
    artist_name character varying NOT NULL
);


ALTER TABLE public.card_artists OWNER TO lorcana_33;

--
-- Name: card_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_artists_id_seq OWNER TO lorcana_33;

--
-- Name: card_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_artists_id_seq OWNED BY public.card_artists.id;


--
-- Name: card_flavor_text; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_flavor_text (
    id integer NOT NULL,
    flavor_text character varying NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_flavor_text OWNER TO lorcana_33;

--
-- Name: card_flavor_text_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_flavor_text_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_flavor_text_id_seq OWNER TO lorcana_33;

--
-- Name: card_flavor_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_flavor_text_id_seq OWNED BY public.card_flavor_text.id;


--
-- Name: card_image_sizes; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_image_sizes (
    id integer NOT NULL,
    image_size integer NOT NULL
);


ALTER TABLE public.card_image_sizes OWNER TO lorcana_33;

--
-- Name: card_image_sizes_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_image_sizes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_image_sizes_id_seq OWNER TO lorcana_33;

--
-- Name: card_image_sizes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_image_sizes_id_seq OWNED BY public.card_image_sizes.id;


--
-- Name: card_image_urls; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_image_urls (
    id integer NOT NULL,
    image_url character varying NOT NULL,
    card_id integer NOT NULL,
    image_size integer NOT NULL,
    downloaded boolean DEFAULT false NOT NULL
);


ALTER TABLE public.card_image_urls OWNER TO lorcana_33;

--
-- Name: card_image_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_image_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_image_urls_id_seq OWNER TO lorcana_33;

--
-- Name: card_image_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_image_urls_id_seq OWNED BY public.card_image_urls.id;


--
-- Name: card_ink; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_ink (
    id integer NOT NULL,
    ink_color character varying NOT NULL
);


ALTER TABLE public.card_ink OWNER TO lorcana_33;

--
-- Name: card_ink_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_ink_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_ink_id_seq OWNER TO lorcana_33;

--
-- Name: card_ink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_ink_id_seq OWNED BY public.card_ink.id;


--
-- Name: card_quest_value; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_quest_value (
    id integer NOT NULL,
    quest_value integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_quest_value OWNER TO lorcana_33;

--
-- Name: card_lore_value_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_lore_value_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_lore_value_id_seq OWNER TO lorcana_33;

--
-- Name: card_lore_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_lore_value_id_seq OWNED BY public.card_quest_value.id;


--
-- Name: card_move_cost; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_move_cost (
    id integer NOT NULL,
    move_cost integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_move_cost OWNER TO lorcana_33;

--
-- Name: card_move_cost_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_move_cost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_move_cost_id_seq OWNER TO lorcana_33;

--
-- Name: card_move_cost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_move_cost_id_seq OWNED BY public.card_move_cost.id;


--
-- Name: card_rarities; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_rarities (
    id integer NOT NULL,
    rarity character varying NOT NULL
);


ALTER TABLE public.card_rarities OWNER TO lorcana_33;

--
-- Name: card_rarities_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_rarities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_rarities_id_seq OWNER TO lorcana_33;

--
-- Name: card_rarities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_rarities_id_seq OWNED BY public.card_rarities.id;


--
-- Name: card_rules_text; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_rules_text (
    id integer NOT NULL,
    card_rules character varying NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_rules_text OWNER TO lorcana_33;

--
-- Name: card_rules_text_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_rules_text_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_rules_text_id_seq OWNER TO lorcana_33;

--
-- Name: card_rules_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_rules_text_id_seq OWNED BY public.card_rules_text.id;


--
-- Name: card_set_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_set_map (
    id integer NOT NULL,
    card_set integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_set_map OWNER TO lorcana_33;

--
-- Name: card_set_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_set_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_set_map_id_seq OWNER TO lorcana_33;

--
-- Name: card_set_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_set_map_id_seq OWNED BY public.card_set_map.id;


--
-- Name: card_set_types; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_set_types (
    id integer NOT NULL,
    set_type character varying NOT NULL
);


ALTER TABLE public.card_set_types OWNER TO lorcana_33;

--
-- Name: card_set_types_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_set_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_set_types_id_seq OWNER TO lorcana_33;

--
-- Name: card_set_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_set_types_id_seq OWNED BY public.card_set_types.id;


--
-- Name: card_sets; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_sets (
    id integer NOT NULL,
    ravensburg_id integer NOT NULL,
    set_name character varying NOT NULL,
    sort_number integer NOT NULL,
    thumbnail_image_url character varying NOT NULL,
    set_type integer,
    image_downloaded boolean DEFAULT false NOT NULL,
    cards_in_set integer
);


ALTER TABLE public.card_sets OWNER TO lorcana_33;

--
-- Name: card_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_sets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_sets_id_seq OWNER TO lorcana_33;

--
-- Name: card_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_sets_id_seq OWNED BY public.card_sets.id;


--
-- Name: card_strength; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_strength (
    id integer NOT NULL,
    strength integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_strength OWNER TO lorcana_33;

--
-- Name: card_strength_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_strength_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_strength_id_seq OWNER TO lorcana_33;

--
-- Name: card_strength_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_strength_id_seq OWNED BY public.card_strength.id;


--
-- Name: card_subtitles; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_subtitles (
    id integer NOT NULL,
    card_id integer NOT NULL,
    subtitle character varying NOT NULL
);


ALTER TABLE public.card_subtitles OWNER TO lorcana_33;

--
-- Name: card_subtitles_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_subtitles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_subtitles_id_seq OWNER TO lorcana_33;

--
-- Name: card_subtitles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_subtitles_id_seq OWNED BY public.card_subtitles.id;


--
-- Name: card_subtype_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_subtype_map (
    id integer NOT NULL,
    card_subtype integer NOT NULL,
    card integer NOT NULL
);


ALTER TABLE public.card_subtype_map OWNER TO lorcana_33;

--
-- Name: card_subtype_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_subtype_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_subtype_map_id_seq OWNER TO lorcana_33;

--
-- Name: card_subtype_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_subtype_map_id_seq OWNED BY public.card_subtype_map.id;


--
-- Name: card_types; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_types (
    id integer NOT NULL,
    card_type character varying NOT NULL
);


ALTER TABLE public.card_types OWNER TO lorcana_33;

--
-- Name: cards_types_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.cards_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_types_id_seq OWNER TO lorcana_33;

--
-- Name: cards_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.cards_types_id_seq OWNED BY public.card_types.id;


--
-- Name: card_subtypes; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_subtypes (
    id integer DEFAULT nextval('public.cards_types_id_seq'::regclass) NOT NULL,
    card_subtype character varying NOT NULL
);


ALTER TABLE public.card_subtypes OWNER TO lorcana_33;

--
-- Name: card_willpower; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.card_willpower (
    id integer NOT NULL,
    willpower integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.card_willpower OWNER TO lorcana_33;

--
-- Name: card_willpower_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.card_willpower_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_willpower_id_seq OWNER TO lorcana_33;

--
-- Name: card_willpower_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.card_willpower_id_seq OWNED BY public.card_willpower.id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.cards (
    id integer NOT NULL,
    name character varying NOT NULL,
    rarity integer NOT NULL,
    ink_cost integer NOT NULL,
    deck_building_id character varying NOT NULL,
    culture_invariant_id integer NOT NULL,
    sort_number integer NOT NULL,
    ink_convertible boolean NOT NULL,
    card_identifier character varying NOT NULL,
    details_loaded boolean DEFAULT false NOT NULL,
    ink_id integer NOT NULL,
    card_type integer NOT NULL
);


ALTER TABLE public.cards OWNER TO lorcana_33;

--
-- Name: cards_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.cards_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_seq OWNER TO lorcana_33;

--
-- Name: cards_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.cards_seq OWNED BY public.cards.id;


--
-- Name: control_table; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.control_table (
    id integer NOT NULL,
    name character varying NOT NULL,
    string_value character varying,
    date_value timestamp with time zone,
    integer_value integer,
    boolean_value boolean,
    high_sensitivity boolean DEFAULT false NOT NULL
);


ALTER TABLE public.control_table OWNER TO lorcana_33;

--
-- Name: control_table_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.control_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.control_table_id_seq OWNER TO lorcana_33;

--
-- Name: control_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.control_table_id_seq OWNED BY public.control_table.id;


--
-- Name: deck_building_limits; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.deck_building_limits (
    id integer NOT NULL,
    deck_building_limit integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.deck_building_limits OWNER TO lorcana_33;

--
-- Name: deck_building_limits_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.deck_building_limits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deck_building_limits_id_seq OWNER TO lorcana_33;

--
-- Name: deck_building_limits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.deck_building_limits_id_seq OWNED BY public.deck_building_limits.id;


--
-- Name: deck_cards; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.deck_cards (
    id integer NOT NULL,
    deck_id integer NOT NULL,
    card_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.deck_cards OWNER TO lorcana_33;

--
-- Name: deck_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.deck_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deck_cards_id_seq OWNER TO lorcana_33;

--
-- Name: deck_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.deck_cards_id_seq OWNED BY public.deck_cards.id;


--
-- Name: deck_sources; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.deck_sources (
    id integer NOT NULL,
    name character varying NOT NULL,
    url character varying NOT NULL
);


ALTER TABLE public.deck_sources OWNER TO lorcana_33;

--
-- Name: deck_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.deck_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deck_sources_id_seq OWNER TO lorcana_33;

--
-- Name: deck_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.deck_sources_id_seq OWNED BY public.deck_sources.id;


--
-- Name: decks; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.decks (
    id integer NOT NULL,
    deck_url character varying,
    deck_name character varying,
    deck_ink1 integer NOT NULL,
    deck_ink2 integer,
    card_composite_hash character varying NOT NULL,
    starter_pack boolean DEFAULT false NOT NULL,
    deck_complete boolean DEFAULT false NOT NULL,
    deck_source integer NOT NULL
);


ALTER TABLE public.decks OWNER TO lorcana_33;

--
-- Name: decks_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.decks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.decks_id_seq OWNER TO lorcana_33;

--
-- Name: decks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.decks_id_seq OWNED BY public.decks.id;


--
-- Name: foil_mask_urls; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.foil_mask_urls (
    id integer NOT NULL,
    foil_mask_url character varying NOT NULL,
    card_id integer NOT NULL,
    downloaded boolean DEFAULT false NOT NULL
);


ALTER TABLE public.foil_mask_urls OWNER TO lorcana_33;

--
-- Name: foil_mask_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.foil_mask_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.foil_mask_urls_id_seq OWNER TO lorcana_33;

--
-- Name: foil_mask_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.foil_mask_urls_id_seq OWNED BY public.foil_mask_urls.id;


--
-- Name: foil_type_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.foil_type_map (
    id integer NOT NULL,
    foil_type integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.foil_type_map OWNER TO lorcana_33;

--
-- Name: foil_type_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.foil_type_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.foil_type_map_id_seq OWNER TO lorcana_33;

--
-- Name: foil_type_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.foil_type_map_id_seq OWNED BY public.foil_type_map.id;


--
-- Name: foil_types; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.foil_types (
    id integer NOT NULL,
    foil_type character varying NOT NULL
);


ALTER TABLE public.foil_types OWNER TO lorcana_33;

--
-- Name: foil_types_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.foil_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.foil_types_id_seq OWNER TO lorcana_33;

--
-- Name: foil_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.foil_types_id_seq OWNED BY public.foil_types.id;


--
-- Name: ink_deck_urls; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.ink_deck_urls (
    id integer NOT NULL,
    url character varying NOT NULL,
    is_page_url boolean NOT NULL,
    scanned boolean DEFAULT false NOT NULL
);


ALTER TABLE public.ink_deck_urls OWNER TO lorcana_33;

--
-- Name: ink_deck_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.ink_deck_urls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ink_deck_urls_id_seq OWNER TO lorcana_33;

--
-- Name: ink_deck_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.ink_deck_urls_id_seq OWNED BY public.ink_deck_urls.id;


--
-- Name: my_cards; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.my_cards (
    id integer NOT NULL,
    card_id integer NOT NULL,
    count integer NOT NULL,
    foil boolean NOT NULL
);


ALTER TABLE public.my_cards OWNER TO lorcana_33;

--
-- Name: my_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.my_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.my_cards_id_seq OWNER TO lorcana_33;

--
-- Name: my_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.my_cards_id_seq OWNED BY public.my_cards.id;


--
-- Name: special_rarity; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.special_rarity (
    id integer NOT NULL,
    special_rarity_id integer NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.special_rarity OWNER TO lorcana_33;

--
-- Name: special_rarity_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.special_rarity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.special_rarity_id_seq OWNER TO lorcana_33;

--
-- Name: special_rarity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.special_rarity_id_seq OWNED BY public.special_rarity.id;


--
-- Name: tcg_price_monitoring; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.tcg_price_monitoring (
    id integer NOT NULL,
    product_id integer NOT NULL,
    foil boolean NOT NULL,
    usd_price real NOT NULL,
    date_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tcg_price_monitoring OWNER TO lorcana_33;

--
-- Name: tcg_price_monitoring_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.tcg_price_monitoring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tcg_price_monitoring_id_seq OWNER TO lorcana_33;

--
-- Name: tcg_price_monitoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.tcg_price_monitoring_id_seq OWNED BY public.tcg_price_monitoring.id;


--
-- Name: tcg_product_mapping; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.tcg_product_mapping (
    id integer NOT NULL,
    card_id integer NOT NULL,
    tcg_product_code integer NOT NULL,
    product_url character varying NOT NULL
);


ALTER TABLE public.tcg_product_mapping OWNER TO lorcana_33;

--
-- Name: tcg_product_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.tcg_product_mapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tcg_product_mapping_id_seq OWNER TO lorcana_33;

--
-- Name: tcg_product_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.tcg_product_mapping_id_seq OWNED BY public.tcg_product_mapping.id;


--
-- Name: varnish_mask_urls; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.varnish_mask_urls (
    id integer NOT NULL,
    card_id integer NOT NULL,
    varnish_mask_url character varying NOT NULL
);


ALTER TABLE public.varnish_mask_urls OWNER TO lorcana_33;

--
-- Name: varnish_mask_url_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.varnish_mask_url_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varnish_mask_url_id_seq OWNER TO lorcana_33;

--
-- Name: varnish_mask_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.varnish_mask_url_id_seq OWNED BY public.varnish_mask_urls.id;


--
-- Name: varnish_type_map; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.varnish_type_map (
    id integer NOT NULL,
    varnish_type integer NOT NULL,
    downloaded boolean DEFAULT false NOT NULL,
    card_id integer NOT NULL
);


ALTER TABLE public.varnish_type_map OWNER TO lorcana_33;

--
-- Name: varnish_type_map_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.varnish_type_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varnish_type_map_id_seq OWNER TO lorcana_33;

--
-- Name: varnish_type_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.varnish_type_map_id_seq OWNED BY public.varnish_type_map.id;


--
-- Name: varnish_types; Type: TABLE; Schema: public; Owner: lorcana_33
--

CREATE TABLE public.varnish_types (
    id integer NOT NULL,
    varnish_type character varying NOT NULL
);


ALTER TABLE public.varnish_types OWNER TO lorcana_33;

--
-- Name: varnish_types_id_seq; Type: SEQUENCE; Schema: public; Owner: lorcana_33
--

CREATE SEQUENCE public.varnish_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.varnish_types_id_seq OWNER TO lorcana_33;

--
-- Name: varnish_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lorcana_33
--

ALTER SEQUENCE public.varnish_types_id_seq OWNED BY public.varnish_types.id;


--
-- Name: card_abilities id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_abilities ALTER COLUMN id SET DEFAULT nextval('public.card_abilities_id_seq'::regclass);


--
-- Name: card_ability_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ability_map ALTER COLUMN id SET DEFAULT nextval('public.card_ability_map_id_seq'::regclass);


--
-- Name: card_additional_info id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_additional_info ALTER COLUMN id SET DEFAULT nextval('public.card_additional_details_id_seq'::regclass);


--
-- Name: card_artist_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artist_map ALTER COLUMN id SET DEFAULT nextval('public.card_artist_map_id_seq'::regclass);


--
-- Name: card_artists id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artists ALTER COLUMN id SET DEFAULT nextval('public.card_artists_id_seq'::regclass);


--
-- Name: card_flavor_text id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_flavor_text ALTER COLUMN id SET DEFAULT nextval('public.card_flavor_text_id_seq'::regclass);


--
-- Name: card_image_sizes id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_sizes ALTER COLUMN id SET DEFAULT nextval('public.card_image_sizes_id_seq'::regclass);


--
-- Name: card_image_urls id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_urls ALTER COLUMN id SET DEFAULT nextval('public.card_image_urls_id_seq'::regclass);


--
-- Name: card_ink id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ink ALTER COLUMN id SET DEFAULT nextval('public.card_ink_id_seq'::regclass);


--
-- Name: card_move_cost id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_move_cost ALTER COLUMN id SET DEFAULT nextval('public.card_move_cost_id_seq'::regclass);


--
-- Name: card_quest_value id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_quest_value ALTER COLUMN id SET DEFAULT nextval('public.card_lore_value_id_seq'::regclass);


--
-- Name: card_rarities id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rarities ALTER COLUMN id SET DEFAULT nextval('public.card_rarities_id_seq'::regclass);


--
-- Name: card_rules_text id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rules_text ALTER COLUMN id SET DEFAULT nextval('public.card_rules_text_id_seq'::regclass);


--
-- Name: card_set_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_map ALTER COLUMN id SET DEFAULT nextval('public.card_set_map_id_seq'::regclass);


--
-- Name: card_set_types id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_types ALTER COLUMN id SET DEFAULT nextval('public.card_set_types_id_seq'::regclass);


--
-- Name: card_sets id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_sets ALTER COLUMN id SET DEFAULT nextval('public.card_sets_id_seq'::regclass);


--
-- Name: card_strength id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_strength ALTER COLUMN id SET DEFAULT nextval('public.card_strength_id_seq'::regclass);


--
-- Name: card_subtitles id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtitles ALTER COLUMN id SET DEFAULT nextval('public.card_subtitles_id_seq'::regclass);


--
-- Name: card_subtype_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtype_map ALTER COLUMN id SET DEFAULT nextval('public.card_subtype_map_id_seq'::regclass);


--
-- Name: card_types id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_types ALTER COLUMN id SET DEFAULT nextval('public.cards_types_id_seq'::regclass);


--
-- Name: card_willpower id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_willpower ALTER COLUMN id SET DEFAULT nextval('public.card_willpower_id_seq'::regclass);


--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_seq'::regclass);


--
-- Name: control_table id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.control_table ALTER COLUMN id SET DEFAULT nextval('public.control_table_id_seq'::regclass);


--
-- Name: deck_building_limits id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_building_limits ALTER COLUMN id SET DEFAULT nextval('public.deck_building_limits_id_seq'::regclass);


--
-- Name: deck_cards id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_cards ALTER COLUMN id SET DEFAULT nextval('public.deck_cards_id_seq'::regclass);


--
-- Name: deck_sources id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_sources ALTER COLUMN id SET DEFAULT nextval('public.deck_sources_id_seq'::regclass);


--
-- Name: decks id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks ALTER COLUMN id SET DEFAULT nextval('public.decks_id_seq'::regclass);


--
-- Name: foil_mask_urls id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_mask_urls ALTER COLUMN id SET DEFAULT nextval('public.foil_mask_urls_id_seq'::regclass);


--
-- Name: foil_type_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_type_map ALTER COLUMN id SET DEFAULT nextval('public.foil_type_map_id_seq'::regclass);


--
-- Name: foil_types id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_types ALTER COLUMN id SET DEFAULT nextval('public.foil_types_id_seq'::regclass);


--
-- Name: ink_deck_urls id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.ink_deck_urls ALTER COLUMN id SET DEFAULT nextval('public.ink_deck_urls_id_seq'::regclass);


--
-- Name: my_cards id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.my_cards ALTER COLUMN id SET DEFAULT nextval('public.my_cards_id_seq'::regclass);


--
-- Name: special_rarity id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.special_rarity ALTER COLUMN id SET DEFAULT nextval('public.special_rarity_id_seq'::regclass);


--
-- Name: tcg_price_monitoring id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_price_monitoring ALTER COLUMN id SET DEFAULT nextval('public.tcg_price_monitoring_id_seq'::regclass);


--
-- Name: tcg_product_mapping id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_product_mapping ALTER COLUMN id SET DEFAULT nextval('public.tcg_product_mapping_id_seq'::regclass);


--
-- Name: varnish_mask_urls id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_mask_urls ALTER COLUMN id SET DEFAULT nextval('public.varnish_mask_url_id_seq'::regclass);


--
-- Name: varnish_type_map id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_type_map ALTER COLUMN id SET DEFAULT nextval('public.varnish_type_map_id_seq'::regclass);


--
-- Name: varnish_types id; Type: DEFAULT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_types ALTER COLUMN id SET DEFAULT nextval('public.varnish_types_id_seq'::regclass);


--
-- Name: card_abilities card_abilities_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_abilities
    ADD CONSTRAINT card_abilities_pkey PRIMARY KEY (id);


--
-- Name: card_abilities card_abilities_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_abilities
    ADD CONSTRAINT card_abilities_unique UNIQUE (ability);


--
-- Name: card_ability_map card_ability_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ability_map
    ADD CONSTRAINT card_ability_map_pkey PRIMARY KEY (id);


--
-- Name: card_ability_map card_ability_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ability_map
    ADD CONSTRAINT card_ability_map_unique UNIQUE (ability_id, card_id);


--
-- Name: card_additional_info card_additional_details_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_additional_info
    ADD CONSTRAINT card_additional_details_pkey PRIMARY KEY (id);


--
-- Name: card_additional_info card_additional_details_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_additional_info
    ADD CONSTRAINT card_additional_details_unique UNIQUE (additional_info, card_id);


--
-- Name: card_artist_map card_artist_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artist_map
    ADD CONSTRAINT card_artist_map_pkey PRIMARY KEY (id);


--
-- Name: card_artist_map card_artist_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artist_map
    ADD CONSTRAINT card_artist_map_unique UNIQUE (artist_id, card_id);


--
-- Name: card_artists card_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artists
    ADD CONSTRAINT card_artists_pkey PRIMARY KEY (id);


--
-- Name: card_artists card_artists_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artists
    ADD CONSTRAINT card_artists_unique UNIQUE (artist_name);


--
-- Name: card_image_sizes card_image_sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_sizes
    ADD CONSTRAINT card_image_sizes_pkey PRIMARY KEY (id);


--
-- Name: card_image_sizes card_image_sizes_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_sizes
    ADD CONSTRAINT card_image_sizes_unique UNIQUE (image_size);


--
-- Name: card_image_urls card_image_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_urls
    ADD CONSTRAINT card_image_urls_pkey PRIMARY KEY (id);


--
-- Name: card_image_urls card_image_urls_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_urls
    ADD CONSTRAINT card_image_urls_unique UNIQUE (card_id, image_size);


--
-- Name: card_ink card_ink_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ink
    ADD CONSTRAINT card_ink_pkey PRIMARY KEY (id);


--
-- Name: card_ink card_ink_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ink
    ADD CONSTRAINT card_ink_unique UNIQUE (ink_color);


--
-- Name: card_quest_value card_lore_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_quest_value
    ADD CONSTRAINT card_lore_pkey_1 PRIMARY KEY (id);


--
-- Name: card_quest_value card_lore_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_quest_value
    ADD CONSTRAINT card_lore_unique_1 UNIQUE (card_id);


--
-- Name: card_rarities card_rarities_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_pkey PRIMARY KEY (id);


--
-- Name: card_rarities card_rarities_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_unique UNIQUE (rarity);


--
-- Name: card_rules_text card_rules_text_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rules_text
    ADD CONSTRAINT card_rules_text_pkey_1 PRIMARY KEY (id);


--
-- Name: card_rules_text card_rules_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rules_text
    ADD CONSTRAINT card_rules_unique UNIQUE (card_id);


--
-- Name: card_set_map card_set_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_map
    ADD CONSTRAINT card_set_map_pkey PRIMARY KEY (id);


--
-- Name: card_set_map card_set_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_map
    ADD CONSTRAINT card_set_map_unique UNIQUE (card_set, card_id);


--
-- Name: card_set_types card_set_types_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_types
    ADD CONSTRAINT card_set_types_pkey PRIMARY KEY (id);


--
-- Name: card_set_types card_set_types_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_types
    ADD CONSTRAINT card_set_types_unique UNIQUE (set_type);


--
-- Name: card_sets card_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_pkey PRIMARY KEY (id);


--
-- Name: card_subtitles card_subtitles_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtitles
    ADD CONSTRAINT card_subtitles_pkey PRIMARY KEY (id);


--
-- Name: card_subtitles card_subtitles_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtitles
    ADD CONSTRAINT card_subtitles_unique UNIQUE (card_id);


--
-- Name: card_subtype_map card_subtype_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtype_map
    ADD CONSTRAINT card_subtype_map_pkey PRIMARY KEY (id);


--
-- Name: card_subtype_map card_subtype_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtype_map
    ADD CONSTRAINT card_subtype_map_unique UNIQUE (card_subtype, card);


--
-- Name: card_willpower card_willpower_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_willpower
    ADD CONSTRAINT card_willpower_pkey PRIMARY KEY (id);


--
-- Name: card_strength card_willpower_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_strength
    ADD CONSTRAINT card_willpower_pkey_1 PRIMARY KEY (id);


--
-- Name: card_willpower card_willpower_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_willpower
    ADD CONSTRAINT card_willpower_unique UNIQUE (card_id);


--
-- Name: card_strength card_willpower_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_strength
    ADD CONSTRAINT card_willpower_unique_1 UNIQUE (card_id);


--
-- Name: cards cards_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_characters_pkey PRIMARY KEY (id);


--
-- Name: card_types cards_types_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_types
    ADD CONSTRAINT cards_types_pkey PRIMARY KEY (id);


--
-- Name: card_subtypes cards_types_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtypes
    ADD CONSTRAINT cards_types_pkey_1 PRIMARY KEY (id);


--
-- Name: cards cards_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_unique UNIQUE (card_identifier);


--
-- Name: control_table control_table_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.control_table
    ADD CONSTRAINT control_table_pkey PRIMARY KEY (id);


--
-- Name: control_table control_table_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.control_table
    ADD CONSTRAINT control_table_unique UNIQUE (name);


--
-- Name: deck_building_limits deck_limit_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_building_limits
    ADD CONSTRAINT deck_limit_pkey_1 PRIMARY KEY (id);


--
-- Name: deck_building_limits deck_limit_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_building_limits
    ADD CONSTRAINT deck_limit_unique_1 UNIQUE (card_id);


--
-- Name: deck_sources deck_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_sources
    ADD CONSTRAINT deck_sources_pkey PRIMARY KEY (id);


--
-- Name: deck_sources deck_sources_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_sources
    ADD CONSTRAINT deck_sources_unique UNIQUE (name);


--
-- Name: deck_sources deck_sources_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_sources
    ADD CONSTRAINT deck_sources_unique_1 UNIQUE (url);


--
-- Name: deck_cards dreamborn_deck_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_cards
    ADD CONSTRAINT dreamborn_deck_cards_pkey PRIMARY KEY (id);


--
-- Name: deck_cards dreamborn_deck_cards_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_cards
    ADD CONSTRAINT dreamborn_deck_cards_unique UNIQUE (deck_id, card_id);


--
-- Name: decks dreamborn_decks_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT dreamborn_decks_pkey PRIMARY KEY (id);


--
-- Name: decks dreamborn_decks_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT dreamborn_decks_unique UNIQUE (card_composite_hash);


--
-- Name: foil_mask_urls foil_mask_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_mask_urls
    ADD CONSTRAINT foil_mask_urls_pkey PRIMARY KEY (id);


--
-- Name: card_flavor_text foil_mask_urls_pkey_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_flavor_text
    ADD CONSTRAINT foil_mask_urls_pkey_1 PRIMARY KEY (id);


--
-- Name: foil_mask_urls foil_mask_urls_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_mask_urls
    ADD CONSTRAINT foil_mask_urls_unique UNIQUE (card_id);


--
-- Name: card_flavor_text foil_mask_urls_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_flavor_text
    ADD CONSTRAINT foil_mask_urls_unique_1 UNIQUE (card_id);


--
-- Name: foil_type_map foil_type_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_type_map
    ADD CONSTRAINT foil_type_map_pkey PRIMARY KEY (id);


--
-- Name: foil_type_map foil_type_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_type_map
    ADD CONSTRAINT foil_type_map_unique UNIQUE (card_id);


--
-- Name: foil_types foil_types_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_types
    ADD CONSTRAINT foil_types_pkey PRIMARY KEY (id);


--
-- Name: foil_types foil_types_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_types
    ADD CONSTRAINT foil_types_unique UNIQUE (foil_type);


--
-- Name: ink_deck_urls ink_deck_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.ink_deck_urls
    ADD CONSTRAINT ink_deck_urls_pkey PRIMARY KEY (id);


--
-- Name: ink_deck_urls ink_deck_urls_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.ink_deck_urls
    ADD CONSTRAINT ink_deck_urls_unique UNIQUE (url);


--
-- Name: card_move_cost move_cost_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_move_cost
    ADD CONSTRAINT move_cost_pkey PRIMARY KEY (id);


--
-- Name: card_move_cost move_cost_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_move_cost
    ADD CONSTRAINT move_cost_unique UNIQUE (card_id);


--
-- Name: my_cards my_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.my_cards
    ADD CONSTRAINT my_cards_pkey PRIMARY KEY (id);


--
-- Name: special_rarity special_rarity_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.special_rarity
    ADD CONSTRAINT special_rarity_pkey PRIMARY KEY (id);


--
-- Name: special_rarity special_rarity_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.special_rarity
    ADD CONSTRAINT special_rarity_unique UNIQUE (card_id);


--
-- Name: tcg_price_monitoring tcg_price_monitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_price_monitoring
    ADD CONSTRAINT tcg_price_monitoring_pkey PRIMARY KEY (id);


--
-- Name: tcg_product_mapping tcg_product_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_product_mapping
    ADD CONSTRAINT tcg_product_mapping_pkey PRIMARY KEY (id);


--
-- Name: tcg_product_mapping tcg_product_mapping_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_product_mapping
    ADD CONSTRAINT tcg_product_mapping_unique UNIQUE (card_id);


--
-- Name: tcg_product_mapping tcg_product_mapping_unique_1; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_product_mapping
    ADD CONSTRAINT tcg_product_mapping_unique_1 UNIQUE (tcg_product_code);


--
-- Name: varnish_mask_urls varnish_mask_url_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_mask_urls
    ADD CONSTRAINT varnish_mask_url_pkey PRIMARY KEY (id);


--
-- Name: varnish_mask_urls varnish_mask_urls_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_mask_urls
    ADD CONSTRAINT varnish_mask_urls_unique UNIQUE (varnish_mask_url);


--
-- Name: varnish_type_map varnish_type_map_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_type_map
    ADD CONSTRAINT varnish_type_map_pkey PRIMARY KEY (id);


--
-- Name: varnish_type_map varnish_type_map_unique; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_type_map
    ADD CONSTRAINT varnish_type_map_unique UNIQUE (card_id);


--
-- Name: varnish_types varnish_types_pkey; Type: CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_types
    ADD CONSTRAINT varnish_types_pkey PRIMARY KEY (id);


--
-- Name: cards_card_identifier_idx; Type: INDEX; Schema: public; Owner: lorcana_33
--

CREATE INDEX cards_card_identifier_idx ON public.cards USING btree (card_identifier);


--
-- Name: cards_deck_building_id_idx; Type: INDEX; Schema: public; Owner: lorcana_33
--

CREATE INDEX cards_deck_building_id_idx ON public.cards USING btree (deck_building_id);


--
-- Name: card_ability_map card_ability_map_card_abilities_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ability_map
    ADD CONSTRAINT card_ability_map_card_abilities_fk FOREIGN KEY (ability_id) REFERENCES public.card_abilities(id);


--
-- Name: card_ability_map card_ability_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_ability_map
    ADD CONSTRAINT card_ability_map_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_additional_info card_additional_details_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_additional_info
    ADD CONSTRAINT card_additional_details_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_artist_map card_artist_map_card_artists_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artist_map
    ADD CONSTRAINT card_artist_map_card_artists_fk FOREIGN KEY (artist_id) REFERENCES public.card_artists(id);


--
-- Name: card_artist_map card_artist_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_artist_map
    ADD CONSTRAINT card_artist_map_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_flavor_text card_flavor_text_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_flavor_text
    ADD CONSTRAINT card_flavor_text_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_image_urls card_image_urls_card_image_sizes_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_urls
    ADD CONSTRAINT card_image_urls_card_image_sizes_fk FOREIGN KEY (image_size) REFERENCES public.card_image_sizes(id);


--
-- Name: card_image_urls card_image_urls_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_image_urls
    ADD CONSTRAINT card_image_urls_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_quest_value card_lore_value_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_quest_value
    ADD CONSTRAINT card_lore_value_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_move_cost card_move_cost_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_move_cost
    ADD CONSTRAINT card_move_cost_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_rules_text card_rules_text_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_rules_text
    ADD CONSTRAINT card_rules_text_cards_fk FOREIGN KEY (id) REFERENCES public.cards(id);


--
-- Name: card_set_map card_set_map_card_sets_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_map
    ADD CONSTRAINT card_set_map_card_sets_fk FOREIGN KEY (card_set) REFERENCES public.card_sets(id);


--
-- Name: card_set_map card_set_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_set_map
    ADD CONSTRAINT card_set_map_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_sets card_sets_card_set_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_card_set_types_fk FOREIGN KEY (set_type) REFERENCES public.card_set_types(id);


--
-- Name: card_strength card_strength_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_strength
    ADD CONSTRAINT card_strength_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_subtitles card_subtitles_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtitles
    ADD CONSTRAINT card_subtitles_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: card_subtype_map card_subtype_map_card_subtypes_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtype_map
    ADD CONSTRAINT card_subtype_map_card_subtypes_fk FOREIGN KEY (card_subtype) REFERENCES public.card_subtypes(id);


--
-- Name: card_subtype_map card_subtype_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_subtype_map
    ADD CONSTRAINT card_subtype_map_cards_fk FOREIGN KEY (card) REFERENCES public.cards(id);


--
-- Name: card_willpower card_willpower_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.card_willpower
    ADD CONSTRAINT card_willpower_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: cards cards_card_rarities_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_card_rarities_fk FOREIGN KEY (rarity) REFERENCES public.card_rarities(id);


--
-- Name: cards cards_card_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_card_types_fk FOREIGN KEY (card_type) REFERENCES public.card_types(id);


--
-- Name: deck_building_limits deck_building_limits_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_building_limits
    ADD CONSTRAINT deck_building_limits_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: decks decks_deck_sources_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT decks_deck_sources_fk FOREIGN KEY (deck_source) REFERENCES public.deck_sources(id);


--
-- Name: deck_cards dreamborn_deck_cards_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_cards
    ADD CONSTRAINT dreamborn_deck_cards_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: deck_cards dreamborn_deck_cards_dreamborn_decks_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.deck_cards
    ADD CONSTRAINT dreamborn_deck_cards_dreamborn_decks_fk FOREIGN KEY (deck_id) REFERENCES public.decks(id);


--
-- Name: decks dreamborn_decks_card_ink_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT dreamborn_decks_card_ink_fk FOREIGN KEY (deck_ink1) REFERENCES public.card_ink(id);


--
-- Name: decks dreamborn_decks_card_ink_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT dreamborn_decks_card_ink_fk_1 FOREIGN KEY (deck_ink2) REFERENCES public.card_ink(id);


--
-- Name: foil_mask_urls foil_mask_urls_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_mask_urls
    ADD CONSTRAINT foil_mask_urls_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: foil_type_map foil_type_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_type_map
    ADD CONSTRAINT foil_type_map_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: foil_type_map foil_type_map_foil_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.foil_type_map
    ADD CONSTRAINT foil_type_map_foil_types_fk FOREIGN KEY (foil_type) REFERENCES public.foil_types(id);


--
-- Name: special_rarity special_rarity_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.special_rarity
    ADD CONSTRAINT special_rarity_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: tcg_price_monitoring tcg_price_monitoring_tcg_product_mapping_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_price_monitoring
    ADD CONSTRAINT tcg_price_monitoring_tcg_product_mapping_fk FOREIGN KEY (product_id) REFERENCES public.tcg_product_mapping(id);


--
-- Name: tcg_product_mapping tcg_product_mapping_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.tcg_product_mapping
    ADD CONSTRAINT tcg_product_mapping_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: varnish_mask_urls varnish_mask_urls_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_mask_urls
    ADD CONSTRAINT varnish_mask_urls_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: varnish_type_map varnish_type_map_cards_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_type_map
    ADD CONSTRAINT varnish_type_map_cards_fk FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- Name: varnish_type_map varnish_type_map_varnish_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: lorcana_33
--

ALTER TABLE ONLY public.varnish_type_map
    ADD CONSTRAINT varnish_type_map_varnish_types_fk FOREIGN KEY (varnish_type) REFERENCES public.varnish_types(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--