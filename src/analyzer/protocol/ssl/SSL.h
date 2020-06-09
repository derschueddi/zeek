#pragma once

#include "events.bif.h"

#include "analyzer/protocol/tcp/TCP.h"
#include "analyzer/protocol/http/HTTP.h"

namespace binpac { namespace SSL { class SSL_Conn; } }

namespace binpac { namespace TLSHandshake { class Handshake_Conn; } }

namespace analyzer { namespace ssl {

class SSL_Analyzer final : public tcp::TCP_ApplicationAnalyzer {
public:
	explicit SSL_Analyzer(Connection* conn);
	~SSL_Analyzer() override;

	// Overriden from Analyzer.
	void Done() override;
	void DeliverStream(int len, const u_char* data, bool orig) override;
	void Undelivered(uint64_t seq, int len, bool orig) override;

	void SendHandshake(uint16_t raw_tls_version, const u_char* begin, const u_char* end, bool orig);

	// Tell the analyzer that encryption has started.
	void StartEncryption();

	StringVal * master_key() { return master_key_; }
	void SetMasterKey(const u_char* ms, int len);

	// Overriden from tcp::TCP_ApplicationAnalyzer.
	void EndpointEOF(bool is_orig) override;

	static analyzer::Analyzer* Instantiate(Connection* conn)
		{ return new SSL_Analyzer(conn); }

  binpac::TLSHandshake::Handshake_Conn* handshake() { return handshake_interp; }

  void ForwardHTTPData(int len, const u_char* data, bool orig);

protected:
	binpac::SSL::SSL_Conn* interp;
	binpac::TLSHandshake::Handshake_Conn* handshake_interp;
	bool had_gap;
	StringVal * master_key_;
	analyzer::http::HTTP_Analyzer* http = nullptr;

};

} } // namespace analyzer::*
