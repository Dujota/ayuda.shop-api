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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    listing_id bigint NOT NULL,
    recipient_id bigint NOT NULL,
    sender_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: listings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.listings (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    type_id bigint NOT NULL,
    title character varying(40) NOT NULL,
    description text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.listings_id_seq OWNED BY public.listings.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    content text NOT NULL,
    conversation_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    provider character varying,
    uid character varying,
    access_token character varying,
    refresh_token character varying,
    image character varying,
    email_verified boolean,
    expires_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.types (
    id bigint NOT NULL,
    tag character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.types_id_seq OWNED BY public.types.id;


--
-- Name: user_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_conversations (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: user_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_conversations_id_seq OWNED BY public.user_conversations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    jti character varying NOT NULL,
    name character varying,
    family_name character varying,
    given_name character varying,
    locale character varying,
    roles_mask integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings ALTER COLUMN id SET DEFAULT nextval('public.listings_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types ALTER COLUMN id SET DEFAULT nextval('public.types_id_seq'::regclass);


--
-- Name: user_conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_conversations ALTER COLUMN id SET DEFAULT nextval('public.user_conversations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (id);


--
-- Name: user_conversations user_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_conversations
    ADD CONSTRAINT user_conversations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_conversations_on_listing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_listing_id ON public.conversations USING btree (listing_id);


--
-- Name: index_conversations_on_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_recipient_id ON public.conversations USING btree (recipient_id);


--
-- Name: index_conversations_on_sender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_sender_id ON public.conversations USING btree (sender_id);


--
-- Name: index_listings_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_listings_on_title ON public.listings USING btree (title);


--
-- Name: index_listings_on_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_type_id ON public.listings USING btree (type_id);


--
-- Name: index_listings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_listings_on_user_id ON public.listings USING btree (user_id);


--
-- Name: index_messages_on_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_conversation_id ON public.messages USING btree (conversation_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- Name: index_services_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_services_on_user_id ON public.services USING btree (user_id);


--
-- Name: index_types_on_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_types_on_tag ON public.types USING btree (tag);


--
-- Name: index_user_conversations_on_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_conversations_on_conversation_id ON public.user_conversations USING btree (conversation_id);


--
-- Name: index_user_conversations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_conversations_on_user_id ON public.user_conversations USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_jti; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_jti ON public.users USING btree (jti);


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_2855ab3029; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_2855ab3029 FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: services fk_rails_51a813203f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT fk_rails_51a813203f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_conversations fk_rails_6f1279cfbb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_conversations
    ADD CONSTRAINT fk_rails_6f1279cfbb FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: messages fk_rails_7f927086d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_7f927086d2 FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: listings fk_rails_baa008bfd2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_baa008bfd2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_conversations fk_rails_baff727535; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_conversations
    ADD CONSTRAINT fk_rails_baff727535 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: listings fk_rails_ee3315a7fb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listings
    ADD CONSTRAINT fk_rails_ee3315a7fb FOREIGN KEY (type_id) REFERENCES public.types(id);


--
-- Name: conversations fk_rails_f0edaae389; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_f0edaae389 FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_f38a865771; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_f38a865771 FOREIGN KEY (listing_id) REFERENCES public.listings(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20221222151657'),
('20221222152343'),
('20221223022838'),
('20221223034622'),
('20221226205817'),
('20221227003654'),
('20230102171824'),
('20230115170557'),
('20230115170941'),
('20230115170947');


