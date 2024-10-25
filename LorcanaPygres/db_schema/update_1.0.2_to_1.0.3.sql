-- Add sensitive flag to control table

ALTER TABLE public.control_table ADD high_sensitivity bool DEFAULT false NOT NULL;

-- Name: tcg_price_monitoring; Type: TABLE; Schema: public; Owner: s0lo_games
--

CREATE TABLE public.tcg_price_monitoring (
    id integer NOT NULL,
    card_id integer NOT NULL,
    usd_price character varying NOT NULL,
    date_time timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE public.tcg_price_monitoring OWNER TO s0lo_games;

-- Name: tcg_price_monitoring_id_seq; Type: SEQUENCE; Schema: public; Owner: s0lo_games
--

CREATE SEQUENCE public.tcg_price_monitoring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tcg_price_monitoring_id_seq OWNER TO s0lo_games;


--
-- Name: tcg_price_monitoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: s0lo_games
--

ALTER SEQUENCE public.tcg_price_monitoring_id_seq OWNED BY public.tcg_price_monitoring.id;


--
-- Name: tcg_product_mapping; Type: TABLE; Schema: public; Owner: s0lo_games
--

CREATE TABLE public.tcg_product_mapping (
    id integer NOT NULL,
    card_id integer NOT NULL,
    tcg_product_code integer NOT NULL
);


ALTER TABLE public.tcg_product_mapping OWNER TO s0lo_games;

--
-- Name: tcg_product_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: s0lo_games
--

CREATE SEQUENCE public.tcg_product_mapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tcg_product_mapping_id_seq OWNER TO s0lo_games;

--
-- Name: tcg_product_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: s0lo_games
--

ALTER SEQUENCE public.tcg_product_mapping_id_seq OWNED BY public.tcg_product_mapping.id;


--
-- Add Indexes to Cards columns for better searching speeds

CREATE INDEX cards_card_identifier_idx ON public.cards USING btree (card_identifier);
CREATE INDEX cards_deck_building_id_idx ON public.cards USING btree (deck_building_id);

