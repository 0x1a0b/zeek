
@load base/frameworks/files

module X509;

export {
	redef enum Log::ID += { LOG };
}

event x509_cert(f: fa_file, cert: X509::Certificate)
	{
	print cert;
	}

event x509_extension(f: fa_file, ext: X509::Extension)
{
print ext;
}

event x509_ext_basic_constraints(f: fa_file, ext: X509::BasicConstraints)
{
print ext;
}

event x509_ext_subject_alternative_name(f: fa_file, ext: X509::SubjectAlternativeName) 
{
print ext;
}

